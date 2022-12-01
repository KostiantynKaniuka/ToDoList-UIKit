//
//  DoneTaskTableViewController.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 21.11.2022.
//

import UIKit
import RealmSwift

final class DoneTaskTableViewController: UITableViewController {
    //MARK: - Outlets
    private let realmManager = RealmManager()
    private var doneTasks: Results<Task>?
    static weak var delegate: SendDoneTaskDataToDescription?
    static weak var editDelegate: ActivateEditMode?
    
    //MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        OngoingTaskTableViewCell.delegate = self
        tableView.backgroundColor = .appBackground
        tableView.register(DoneTaskTableViewCell.self, forCellReuseIdentifier: DoneTaskTableViewCell.reuseID)
        readDoneTaskAndUpdateUi()
    }
    
    //MARK: - Methods
    private func readDoneTaskAndUpdateUi() {
        doneTasks = realmManager.localRealm?.objects(Task.self).filter("completed = true").sorted(byKeyPath: "dateOfAdding", ascending: false)
        tableView.reloadData()
    }
}

//MARK: - TableView Data Source
extension DoneTaskTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DoneTaskTableViewCell.reuseID, for: indexPath) as? DoneTaskTableViewCell else { return UITableViewCell() }
        let task = doneTasks?[indexPath.row] ?? Task()
        cell.configure(with: task)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  doneTasks?.count ?? 1
    }
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = doneTasks?[indexPath.row] ?? Task()
        self.present(DescriptionViewController(), animated: true) {
            DoneTaskTableViewController.delegate?.didSendDoneData(from: task)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //Edit
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: { (action, view, success) in
            let task = self.doneTasks?[indexPath.row] ?? Task()
            self.present(DescriptionViewController(), animated: true) {
                DoneTaskTableViewController.delegate?.didSendDoneData(from: task)
                DoneTaskTableViewController.editDelegate?.editButtonDidPressed()
            }
        })
        //Delete
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, success) in
            let task = self.doneTasks?[indexPath.row] ?? Task()
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

extension DoneTaskTableViewController: DoneTaskTableViewControllerDelegate {
    
    func didDoneButtonTapped() {
        readDoneTaskAndUpdateUi()
    }
}
