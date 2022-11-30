//
//  EditCalendarViewDelegate .swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 29.11.2022.
//

import Foundation

protocol EditCalendarViewDelegate: AnyObject {
    func editCalendarViewDidSelectDate(date: Date)
}
