//
//  NameLabel.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 29.11.2022.
//

import UIKit

class NameLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        labelFieldSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func labelFieldSettings() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .appBackground
        self.font = UIFont(name: "SanFrancisco", size: 10)
        self.textAlignment = .left
    }
}
