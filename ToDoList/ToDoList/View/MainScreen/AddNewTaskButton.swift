//
//  AddNewTaskButton.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 23.11.2022.
//

import UIKit

final class AddNewTaskButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        buttonSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buttonSettings() {
        let image = UIImage(systemName: "plus") as UIImage?
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .black
        configuration.cornerStyle = .capsule
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 25, bottom: 25, trailing: 25)
        self.configuration = configuration
        self.setImage(image, for: .normal)
    }
}
