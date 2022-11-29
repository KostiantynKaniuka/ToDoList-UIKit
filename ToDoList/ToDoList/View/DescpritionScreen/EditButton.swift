//
//  EditButton.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 29.11.2022.
//

import UIKit

final class EditButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        buttonSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

        private func buttonSettings() {
            let image = UIImage(systemName: "pencil") as UIImage?
            var configuration = UIButton.Configuration.filled()
            configuration.baseBackgroundColor = .systemBlue
            configuration.cornerStyle = .capsule
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 25, bottom: 25, trailing: 25)
            self.configuration = configuration
            self.setImage(image, for: .normal)
            self.layer.shadowRadius = 3.0
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSizeMake(1.0, 1.0)
            self.layer.shadowOpacity = 1.0
        }
}
