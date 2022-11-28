//
//  DescriptionTextField.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 28.11.2022.
//

import UIKit

class DescriptionTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        textFieldSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func textFieldSettings() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .appBackground
        self.font = UIFont(name: "SanFrancisco", size: 17)
        self.textAlignment = .left
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 3.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSizeMake(1.0, 1.0)
        self.layer.shadowOpacity = 1.0
        self.textAlignment = .center
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.isEnabled = false
    }
}
