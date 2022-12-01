//
//  NotificationManager.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 30.11.2022.
//

import Foundation
import UserNotifications

final class NotificationManager {
    let center = UNUserNotificationCenter.current()
    
    
    
    func setupNotifications(id: String, contentTitle: String, contentBody: String, date: Date) {
        center.getNotificationSettings { (settings) in
            if (settings.authorizationStatus == .authorized) {
                let content = UNMutableNotificationContent()
                content.title = contentTitle
                content.body = contentBody
                content.sound = .default
                
                let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .second], from: Date().addingTimeInterval(5))
                
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                let request2 = UNNotificationRequest(identifier: id, content: content, trigger: trigger2)
                self.center.add(request)
                }
            }
        
        
        func removeNotifications(withIdentifiers identifiers: [String]) {
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
        }
    }
}
