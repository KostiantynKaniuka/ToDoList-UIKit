//
//  CalendarViewDelegate.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 28.11.2022.
//

import Foundation

protocol CalendarViewDelegate: AnyObject {
    func calendarViewDidSelectDate(date: Date)
    func calendarViewDidTapRemoveButton()
}
