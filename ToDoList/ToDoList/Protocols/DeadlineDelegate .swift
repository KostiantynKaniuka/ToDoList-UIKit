//
//  DeadlineDelegate .swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 28.11.2022.
//

import Foundation

protocol DeadlineDelegate: AnyObject {
    func isDeadlineAddedToTask(_ task: Task)
}

