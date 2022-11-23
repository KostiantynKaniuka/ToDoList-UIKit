//
//  CalendarButton.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 23.11.2022.
//

import UIKit

final class CalendarButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        buttonSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buttonSettings() {
        let imageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .black)
        let image = UIImage(systemName: "calendar", withConfiguration: imageConfiguration) as UIImage?
        var calendarButtonconfiguration = UIButton.Configuration.gray()
        calendarButtonconfiguration.baseBackgroundColor = .clear
        calendarButtonconfiguration.cornerStyle = .capsule
        self.configuration = calendarButtonconfiguration
        self.setImage(image, for: .normal)
    }
}
