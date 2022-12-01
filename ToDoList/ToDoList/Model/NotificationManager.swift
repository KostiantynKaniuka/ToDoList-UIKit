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
//        removeNotifications(withIdentifiers: [id])
//        center.removeAllPendingNotificationRequests()

        center.getNotificationSettings { (settings) in
            if (settings.authorizationStatus == .authorized) {
                let content = UNMutableNotificationContent()
                content.title = contentTitle
                content.body = contentBody
                content.sound = .default
                var date = DateComponents()
                   date.hour = 12
                   date.minute = 50
                   date.month = 12
                   date.day = 1
                   date.year = 2022
        
                //let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour], from: date.addingTimeInterval(5))
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
                let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                let request2 = UNNotificationRequest(identifier: id, content: content, trigger: trigger2)
                self.center.add(request)
               // self.center.add(request2)
            }
        }
    }
    
    private func removeNotifications(withIdentifiers identifiers: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
    }
}
