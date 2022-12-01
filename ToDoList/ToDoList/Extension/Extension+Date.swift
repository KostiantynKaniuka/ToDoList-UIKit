//
//  Extension+Date.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 28.11.2022.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM, d, YYYY"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "GTM+2")
        return formatter.string(from: self)
    }
}


