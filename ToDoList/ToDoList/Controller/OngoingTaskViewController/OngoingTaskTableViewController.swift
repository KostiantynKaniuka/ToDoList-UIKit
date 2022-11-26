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
    private var tasks: Results<Task>?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .appBackground
        tableView.register(OngoingTaskTableViewCell.self, forCellReuseIdentifier: OngoingTaskTableViewCell.reuseID)
       readTaskAndUpdateUi()
    }
    
    func readTaskAndUpdateUi() {
        tasks = realmManager.localRealm?.objects(Task.self)
        tableView.reloadData()
    }
}

extension OngoingTaskTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OngoingTaskTableViewCell.reuseID, for: indexPath) as? OngoingTaskTableViewCell else { return UITableViewCell() }
        let task = tasks?[indexPath.row] ?? Task()
        cell.configure(with: task)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 1
    }
}
