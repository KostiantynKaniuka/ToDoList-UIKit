//
//  TaskTextField.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 23.11.2022.
//

import UIKit

class TaskTextField: UITextField {
    private let textField = UITextField ()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        textFieldSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func textFieldSettings() {
        textField.backgroundColor = .systemBackground
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = UIFont(name: "Avenir Next", size: 17)
        textField.placeholder = " Enter a new task"
    }
}
