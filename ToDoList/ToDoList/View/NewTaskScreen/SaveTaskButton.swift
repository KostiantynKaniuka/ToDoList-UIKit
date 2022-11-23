//
//  SaveTaskButton.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 23.11.2022.
//

import UIKit

final class SaveTaskButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        buttonSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buttonSettings() {
        let attributedText = NSMutableAttributedString(string: "Save", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.kern: 1
        ])
        var saveButtonConfiguration = UIButton.Configuration.gray()
        saveButtonConfiguration.baseBackgroundColor = .black
        self.configuration = saveButtonConfiguration
        self.setAttributedTitle(attributedText, for: .normal)
    }
}
