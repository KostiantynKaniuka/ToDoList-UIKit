//
//  VerticalStackView.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 23.11.2022.
//

import UIKit

final class VerticalStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
           stackViewSettings()
   }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func stackViewSettings() {
        self.axis = .vertical
        self.distribution = .fill
        self.alignment = .fill
        self.spacing = 16
    }
}
