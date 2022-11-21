//
//  ViewController.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 21.11.2022.
//

import UIKit

class MainViewController: UIViewController {
    private let segmentControll = UISegmentedControl()
    private let ongoingTaskViewController = OngoingTaskTableViewController()
    private let doneTaskViewController = DoneTaskTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ongoingTaskViewController.tableView.isHidden = true
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
        
        //SegmentControll
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentControll.setTitleTextAttributes(titleTextAttributes, for:.normal)
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentControll.setTitleTextAttributes(titleTextAttributes1, for:.selected)
        segmentControll.backgroundColor = .black
        segmentControll.layer.borderColor = UIColor.darkGray.cgColor
        segmentControll.selectedSegmentTintColor = UIColor.white
        segmentControll.layer.borderWidth = 1
    }
    
    private func layout() {
        let bottomContainer = UIView()
        bottomContainer.backgroundColor = .white
        navigationItem.titleView = segmentControll
        addChild(doneTaskViewController)
        addChild(ongoingTaskViewController)
        doneTaskViewController.view.translatesAutoresizingMaskIntoConstraints = false
        ongoingTaskViewController.view.translatesAutoresizingMaskIntoConstraints = false
        segmentControll.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentControll)
        view.addSubview(bottomContainer)
        view.addSubview(ongoingTaskViewController.view)
        view.addSubview(doneTaskViewController.view)
        
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
            doneTaskViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func adjustSegmentControll() {
        MenuSection.allCases.enumerated().forEach { (index, section) in
            segmentControll.insertSegment(withTitle: section.rawValue, at: index, animated: false)
        }
        segmentControll.selectedSegmentIndex = 0
    }
}

