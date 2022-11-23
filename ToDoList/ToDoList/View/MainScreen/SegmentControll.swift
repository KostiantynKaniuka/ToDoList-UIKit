//
//  SegmentControll.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 23.11.2022.
//

import UIKit

final class SegmentControll: UISegmentedControl {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        segmentControllSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func segmentControllSettings() {
        let firstTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let secondTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.setTitleTextAttributes(firstTextAttributes, for:.normal)
        self.setTitleTextAttributes(secondTextAttributes, for:.selected)
        self.backgroundColor = .black
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.selectedSegmentTintColor = UIColor.white
        self.layer.borderWidth = 1
    }
}
