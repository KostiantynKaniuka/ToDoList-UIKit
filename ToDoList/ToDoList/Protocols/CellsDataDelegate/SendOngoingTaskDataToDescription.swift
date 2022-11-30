//
//  SendOngoingTaskDataToDescription.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 29.11.2022.
//

import Foundation

protocol SendOngoingTaskDataToDescription: AnyObject {
    func didSendData(from task: Task)
}
