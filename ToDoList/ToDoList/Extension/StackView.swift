//
//  StackView.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 30.11.2022.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
