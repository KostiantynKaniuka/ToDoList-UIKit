//
//  DescriptionViewController.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 27.11.2022.
//

import UIKit
import RealmSwift

final class DescriptionViewController: UIViewController {
    private let taskNameTextField = DescriptionTextField()
    private let dateOfAddingTextField = DescriptionTextField()
    private let shortDescriptionTextField = DescriptionTextField()
    private let deadlineTextField = DescriptionTextField()
    private let completedDateTextField = DescriptionTextField()
    private let verticalStackView = VerticalStackView()
    private let taskNameLabel = NameLabel()
    private let dateOfAddingLabel = NameLabel()
    private let shortDescriptionLabel = NameLabel()
    private let deadlineLabel = NameLabel()
    private let completedDateLabel = NameLabel()
    private let doneButton = UIButton()
    private let editButton = UIButton()
    private let deleteButton = UIButton()
    
    override func viewDidLoad() {
        OngoingTaskTableViewController.delegate = self
        DoneTaskTableViewController.delegate = self
        super.viewDidLoad()
        view.backgroundColor = .appBackground
        verticalStackView.spacing = 8
        setupViews()
        layout()
    }
}

extension DescriptionViewController {
    
    private func setupViews() {
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        taskNameLabel.text = "Task name"
        dateOfAddingLabel.text = "Date of adding"
        shortDescriptionLabel.text = "Short description"
        deadlineLabel.text = "Deadline"
        completedDateLabel.text = "Completed Date"
    }
    
    private func layout() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.addArrangedSubview(taskNameLabel)
        verticalStackView.addArrangedSubview(taskNameTextField)
        verticalStackView.addArrangedSubview(shortDescriptionLabel)
        verticalStackView.addArrangedSubview(shortDescriptionTextField)
        verticalStackView.addArrangedSubview(dateOfAddingLabel)
        verticalStackView.addArrangedSubview(dateOfAddingTextField)
        verticalStackView.addArrangedSubview(deadlineLabel)
        verticalStackView.addArrangedSubview(deadlineTextField)
        verticalStackView.addArrangedSubview(completedDateLabel)
        verticalStackView.addArrangedSubview(completedDateTextField)
        
        view.addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
        ])
    }
}

extension DescriptionViewController: SendOngoingTaskDataToDescription {
    
    func didSendData(from task: Task) {
        taskNameTextField.text = task.title
        dateOfAddingTextField.text = task.dateOfAdding.toString()
        deadlineTextField.text = task.deadlineDate?.toString()
    }
}

extension DescriptionViewController: SendDoneTaskDataToDescription {
    func didSendDoneData(from task: Task) {
        taskNameTextField.text = task.title
        completedDateTextField.text = task.doneAt?.toString()
        dateOfAddingTextField.text = task.dateOfAdding.toString()
        deadlineTextField.text = task.deadlineDate?.toString()
    }
}
