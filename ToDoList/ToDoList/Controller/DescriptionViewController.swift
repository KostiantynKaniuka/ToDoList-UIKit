//
//  DescriptionViewController.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 27.11.2022.
//

import UIKit
import RealmSwift

protocol SendDataToDescription: AnyObject {
    func didSendData(from task: Task)
}

final class DescriptionViewController: UIViewController {
    private let taskNameTextField = DescriptionTextField()
    private let dateOfAddingTextField = DescriptionTextField()
    private let shortDescriptionTextField = DescriptionTextField()
    private let deadlineTextField = DescriptionTextField()
    private let actualCompletionTextField = DescriptionTextField()
    private let completedDateTextField = DescriptionTextField()
    private let verticalStackView = VerticalStackView()
    private let doneButton = UIButton()
    private let editButton = UIButton()
    private let deleteButton = UIButton()
    
    override func viewDidLoad() {
        OngoingTaskTableViewController.delegate = self
        super.viewDidLoad()
        view.backgroundColor = .appBackground
        layout()
    }
    
    
}

extension DescriptionViewController {
    
    private func layout() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.addArrangedSubview(taskNameTextField)
        verticalStackView.addArrangedSubview(shortDescriptionTextField)
        verticalStackView.addArrangedSubview(dateOfAddingTextField)
        verticalStackView.addArrangedSubview(deadlineTextField)
        verticalStackView.addArrangedSubview(actualCompletionTextField)
        verticalStackView.addArrangedSubview(completedDateTextField)
        
        view.addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
        ])
    }
}

extension DescriptionViewController: SendDataToDescription {
    func didSendData(from task: Task) {
       taskNameTextField.text = task.title
        dateOfAddingTextField.text = task.dateOfAdding.toString()
       deadlineTextField.text = task.deadlineDate?.toString()
    
    
    
        
    }
    
    
}
