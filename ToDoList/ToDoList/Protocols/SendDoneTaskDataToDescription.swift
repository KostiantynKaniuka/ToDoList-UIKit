//
//  SendDoneTaskDataToDescription.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 29.11.2022.
//

import UIKit

protocol SendDoneTaskDataToDescription: AnyObject {
    func didSendDoneData(from task: Task)
}
