//
//  BottomContainer.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 21.11.2022.
//

import UIKit

class BottomContainer: UIView {

        override init(frame: CGRect) {
            super.init(frame: frame)
            
            style()
            layout()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize: CGSize {
            return CGSize(width: 200, height: 200)
        }
    }
    
    extension BottomContainer {
        
        private func style() {
            translatesAutoresizingMaskIntoConstraints = false
            backgroundColor = .orange
        }
        
        private func layout() {
            translatesAutoresizingMaskIntoConstraints = false
        }
    }


