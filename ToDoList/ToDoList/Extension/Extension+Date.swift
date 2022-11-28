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
        
        return formatter.string(from: self)
    }
}
