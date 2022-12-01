//
//  UIView.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 30.11.2022.
//

import UIKit

extension UIView {
    
    func add(subviews: UIView...) {
        for subview in subviews {
            self.addSubview(subview)
        }
    }
}
