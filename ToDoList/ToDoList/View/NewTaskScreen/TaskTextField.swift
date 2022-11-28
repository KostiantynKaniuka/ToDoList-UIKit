//
//  TaskTextField.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 23.11.2022.
//

import UIKit

final class TaskTextField: UITextField {

     override init(frame: CGRect) {
         super.init(frame:frame)
            textFieldSettings()
    }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    private func textFieldSettings() {
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.font = UIFont(name: "San Francisco", size: 17)
        self.placeholder = " Enter a new task"
        self.layer.shadowRadius = 3.0
    }
 }
