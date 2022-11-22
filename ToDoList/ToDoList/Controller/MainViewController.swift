//
//  ViewController.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 21.11.2022.
//

import UIKit

final class MainViewController: UIViewController {
    private let segmentControll = UISegmentedControl()
    private let ongoingTaskViewController = OngoingTaskTableViewController()
    private let doneTaskViewController = DoneTaskTableViewController()
    private let addNewTaskButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        //addNewTaskButton
        let image = UIImage(systemName: "plus") as UIImage?
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .black
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 25, bottom: 25, trailing: 25)
        addNewTaskButton.configuration = config
        addNewTaskButton.setImage(image, for: .normal)
        //SegmentControll
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentControll.setTitleTextAttributes(titleTextAttributes, for:.normal)
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentControll.setTitleTextAttributes(titleTextAttributes1, for:.selected)
        segmentControll.backgroundColor = .black
        segmentControll.layer.borderColor = UIColor.darkGray.cgColor
        segmentControll.selectedSegmentTintColor = UIColor.white
        segmentControll.layer.borderWidth = 1
        //Action
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
        present(NewTaskViewController(), animated: false, completion: nil)
    }
}
