//
//  MainViewControllerDelegate.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 25.11.2022.
//

import Foundation

protocol MainViewControllerDelegate: AnyObject {
    func didAddTask(_ task: Task)
}
