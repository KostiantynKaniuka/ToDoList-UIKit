//
//  OngoingTaskTableViewController.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 21.11.2022.
//

import UIKit
import RealmSwift

final class OngoingTaskTableViewController: UITableViewController {
    private let realmManager = RealmManager()
    private var newTasks: Results<Task>?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .appBackground
        tableView.register(OngoingTaskTableViewCell.self, forCellReuseIdentifier: OngoingTaskTableViewCell.reuseID)
       readTaskAndUpdateUi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readTaskAndUpdateUi()
    }
    
    func readTaskAndUpdateUi() {
        newTasks = realmManager.localRealm?.objects(Task.self).filter("completed = false").sorted(byKeyPath: "dateOfAdding", ascending: false)
        tableView.reloadData()
    }
    
    private func handleDoneButton(for task: Task) {
         let id = task._id
        realmManager.updateTask(id: id, completed: true, date: Date())
        tableView.reloadData()
    }
}

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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newTasks?.count ?? 1
    }
}
