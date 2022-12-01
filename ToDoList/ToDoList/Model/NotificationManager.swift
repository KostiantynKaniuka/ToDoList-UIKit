//
//  NotificationManager.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 30.11.2022.
//

import Foundation
import UserNotifications

final class NotificationManager {
    private let center = UNUserNotificationCenter.current()
    
    func setupNotifications(id: String, deadline:Date?) {
        if deadline != nil {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: deadline ?? Date())
            let minute = calendar.component(.minute, from: deadline ?? Date())
            let second = calendar.component(.second, from: deadline ?? Date())
            let day = calendar.component(.day, from: deadline ?? Date())
            let month = calendar.component(.month, from: deadline ?? Date())
            let content = UNMutableNotificationContent()
            content.title = "To Do"
            content.subtitle = "🔥The deadline for: \(id) is today!"
            content.sound = .default
            var operationDate = DateComponents()
            operationDate.hour = hour
            operationDate.minute = minute
            operationDate.second = second
            operationDate.month = month
            operationDate.day = day
            //Trigger
            let trigger = UNCalendarNotificationTrigger(dateMatching: operationDate, repeats: false)
            //Request
            let requst = UNNotificationRequest(
                identifier: id, content: content,trigger: trigger
            )
            UNUserNotificationCenter.current().add(requst)
        }
    }
        
        func removeNotifications(withIdentifiers identifiers: [String]) {
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
        }
    }
