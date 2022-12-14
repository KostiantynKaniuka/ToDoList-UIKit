//
//  OngoingTaskTableViewController.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 21.11.2022.
//

import UIKit
import RealmSwift

final class OngoingTaskTableViewController: UITableViewController {
    //MARK: - Properties
    private let realmManager = RealmManager()
    private var newTasks: Results<Task>?
    static weak var delegate: SendOngoingTaskDataToDescription?
    static weak var editDelegate: ActivateEditMode?
    let notificationManager = NotificationManager()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setubViews()
        readTaskAndUpdateUi()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readTaskAndUpdateUi()
    }
    
    //MARK: - Methods
    private func handleDoneButton(for task: Task) {
        let id = task._id
        realmManager.updateTask(id: id, completed: true, date: Date())
        tableView.reloadData()
    }
    
    private func setubViews() {
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = .appBackground
        tableView.register(OngoingTaskTableViewCell.self, forCellReuseIdentifier: OngoingTaskTableViewCell.reuseID)
    }
    
    func readTaskAndUpdateUi() {
        newTasks = realmManager.localRealm?.objects(Task.self).filter("completed = false").sorted(byKeyPath: "dateOfAdding", ascending: false)
        tableView.reloadData()
    }
}

//MARK: - TableView Data Source
extension OngoingTaskTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OngoingTaskTableViewCell.reuseID, for: indexPath) as? OngoingTaskTableViewCell else { return UITableViewCell() }
        let task = newTasks?[indexPath.row] ?? Task()
        cell.doneButtonDidTap = { [weak self] in
            self?.handleDoneButton(for: task)
        }
        cell.configure(with: task)
        
        return cell
    }
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newTasks?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = newTasks?[indexPath.row] ?? Task()
        self.present(DescriptionViewController(), animated: true) {
            OngoingTaskTableViewController.delegate?.didSendData(from: task)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Spipable buttons
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //Edit
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: { (action, view, success) in
            let task = self.newTasks?[indexPath.row] ?? Task()
            self.present(DescriptionViewController(), animated: true) {
                OngoingTaskTableViewController.delegate?.didSendData(from: task)
                OngoingTaskTableViewController.editDelegate?.editButtonDidPressed()
            }
        })
        //Delete
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, success) in
            let task = self.newTasks?[indexPath.row] ?? Task()
            let id = task._id
            self.realmManager.deleteTask(id: id)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        })
        //Button style settings
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        editAction.backgroundColor = .systemBlue
        editAction.image = UIImage(systemName: "pencil")
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}
