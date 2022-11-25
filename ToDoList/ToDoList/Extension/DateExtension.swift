//
//  DateExtension.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 26.11.2022.
//

import Foundation

extension Date {
    // Convert UTC (or GMT) to local time
        func localDate() -> Date {
            let nowUTC = Date()
            let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
            guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}

            return localDate
        }
    }

