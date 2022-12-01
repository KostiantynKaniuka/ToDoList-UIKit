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
    
    
    
    func setupNotifications(id: String, contentTitle: String, contentBody: String, date: Date?) {
//        center.getNotificationSettings { (settings) in
//            if (settings.authorizationStatus == .authorized) {
//                let content = UNMutableNotificationContent()
//                content.title = contentTitle
//                content.body = contentBody
//                content.sound = .default
//                let newdate = date?.addingTimeInterval(5)
//                let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .second], from: newdate!)
//                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
//                self.center.add(request)
//
//                }
        
        mypushNotification(input: date!.addingTimeInterval(10), text: "kek")
            }
        
        func mypushNotification(input:Date,text:String) {
                
               let calendar = Calendar.current
               
               let hour = calendar.component(.hour, from: input)
               let minute = calendar.component(.minute, from: input)
               let second = calendar.component(.second, from: input)
               let day = calendar.component(.day, from: input)
               let month = calendar.component(.month, from: input)
               
               
               let content = UNMutableNotificationContent()
               content.title = "Let's make it DONE 💪"
               content.subtitle = text
               content.sound = .default
              
               
               var dateC=DateComponents()
               
               dateC.hour=hour
               dateC.minute=minute
               dateC.second=second
               dateC.month=month
               dateC.day=day
               
               
               let trigger = UNCalendarNotificationTrigger(dateMatching: dateC, repeats: false)
               
               let requst = UNNotificationRequest(
                   identifier: UUID().uuidString, content: content,trigger: trigger
               )
               UNUserNotificationCenter.current().add(requst)
           }
        
        
        func removeNotifications(withIdentifiers identifiers: [String]) {
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
        }
    
}
