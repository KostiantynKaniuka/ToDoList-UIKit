//
//  ViewController.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 21.11.2022.
//

import UIKit
import RealmSwift
import UserNotifications

final class MainViewController: UIViewController {
    private let segmentControll = SegmentControll(frame: .null)
    private let ongoingTaskViewController = OngoingTaskTableViewController()
    private let doneTaskViewController = DoneTaskTableViewController()
    private let addNewTaskButton = AddNewTaskButton()
    private var realm = RealmManager()
    let notification = UNUserNotificationCenter.current()
    let notificationManager  = NotificationManager()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        NewTaskViewController.delegate = self
        DescriptionViewController.delegate = self
        style()
        layout()
        adjustSegmentControll()
    }
}

extension MainViewController {
    
    private func style() {
        view.backgroundColor = .appBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Tasks"
        segmentControll.addTarget(self, action: #selector(segmentControlChanged), for: .valueChanged)
        addNewTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
    }
    
    private func layout() {
        let bottomContainer = UIView()
        bottomContainer.backgroundColor = .appBackground
        navigationItem.titleView = segmentControll
        addChild(doneTaskViewController)
        addChild(ongoingTaskViewController)
        doneTaskViewController.view.translatesAutoresizingMaskIntoConstraints = false
        ongoingTaskViewController.view.translatesAutoresizingMaskIntoConstraints = false
        segmentControll.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        addNewTaskButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentControll)
        view.addSubview(bottomContainer)
        view.addSubview(ongoingTaskViewController.view)
        view.addSubview(doneTaskViewController.view)
        view.addSubview(addNewTaskButton)
        
        //bottom container
        NSLayoutConstraint.activate([
            bottomContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomContainer.heightAnchor.constraint(equalToConstant: 100),
            
            //Ongoing task view container
            ongoingTaskViewController.view.bottomAnchor.constraint(equalTo: bottomContainer.topAnchor),
            ongoingTaskViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ongoingTaskViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ongoingTaskViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //Done task view container
            doneTaskViewController.view.bottomAnchor.constraint(equalTo: bottomContainer.topAnchor),
            doneTaskViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            doneTaskViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            doneTaskViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //Add new task button
            addNewTaskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addNewTaskButton.centerYAnchor.constraint(equalTo: bottomContainer.firstBaselineAnchor)
        ])
    }
    
    private func adjustSegmentControll() {
        MenuSection.allCases.enumerated().forEach { (index, section) in
            segmentControll.insertSegment(withTitle: section.rawValue, at: index, animated: false)
        }
        segmentControll.selectedSegmentIndex = 0
        showContainerView(for: .ongoing)
    }
    
    private func showContainerView(for section: MenuSection) {
        switch section {
        case .ongoing:
            ongoingTaskViewController.tableView.isHidden = false
            doneTaskViewController.tableView.isHidden = true
        case .done:
            ongoingTaskViewController.tableView.isHidden = true
            doneTaskViewController.tableView.isHidden = false
        }
    }
    
    @objc private func segmentControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            showContainerView(for: .ongoing)
        case 1:
            showContainerView(for: .done)
        default:
            break
        }
    }
    
    @objc private func addTaskButtonTapped(_ sender: UIButton) {
        present(NewTaskViewController(), animated: true, completion: nil)
        }
    }

extension MainViewController: MainViewControllerDelegate {
    
    func didAddTask(_ task: Task) {
        presentedViewController?.dismiss(animated: true, completion: { [unowned self] in
            self.realm.addTask(title: task.title, deadlineDate: task.deadlineDate, shortDescription: task.shortDescription)
            ongoingTaskViewController.readTaskAndUpdateUi()
            
           notificationManager.setupNotifications(id: task.title, contentTitle: "To Do", contentBody: "Dead Line", date: task.dateOfAdding)
            
        
            
        })
    }
}

extension MainViewController: UpdateChanges {
    func refreshTableView() {
        ongoingTaskViewController.tableView.reloadData()
        doneTaskViewController.tableView.reloadData()
        
    }
}

extension MainViewController {

    private func scheduleNotification(in senonds: TimeInterval, completion: (Bool) -> ()) {
        removeNotifications(withIdentifiers: ["String"])
        let date = Date(timeIntervalSinceNow: senonds)
        print(Date())
        print(date)
        let content = UNMutableNotificationContent()
        content.title = "To Do"
        content.body = "LOL"
        content.sound = .default

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "String", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }

    private func removeNotifications(withIdentifiers identifiers: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
    }
}
