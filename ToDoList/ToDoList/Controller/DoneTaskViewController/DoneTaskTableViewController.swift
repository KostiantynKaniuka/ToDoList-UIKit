//
//  DoneTaskTableViewController.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 21.11.2022.
//

import UIKit
import RealmSwift

class DoneTaskTableViewController: UITableViewController {
    private let realmManager = RealmManager()
    private var doneTasks: Results<Task>?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        OngoingTaskTableViewCell.delegate = self
        tableView.backgroundColor = .appBackground
        tableView.register(DoneTaskTableViewCell.self, forCellReuseIdentifier: DoneTaskTableViewCell.reuseID)
        readDoneTaskAndUpdateUi()
    }
    
    func readDoneTaskAndUpdateUi() {
        doneTasks = realmManager.localRealm?.objects(Task.self).filter("completed = true").sorted(byKeyPath: "dateOfAdding", ascending: false)
        tableView.reloadData()
    }
}

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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = doneTasks?[indexPath.row] ?? Task()
            let id = task._id
            realmManager.deleteTask(id: id)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

extension DoneTaskTableViewController: DoneTaskTableViewControllerDelegate {
    func didDoneButtonTapped() {
        readDoneTaskAndUpdateUi()
    }
}
