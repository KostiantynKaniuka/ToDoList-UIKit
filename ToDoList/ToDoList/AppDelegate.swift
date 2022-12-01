//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 21.11.2022.
//

import UIKit
import RealmSwift
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var taskId: ObjectId?
    let realmManager = RealmManager()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        let navigationController = UINavigationController(rootViewController: ToDoListViewController())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
        window?.backgroundColor = .appBackground
        window?.rootViewController = navigationController
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granded, error in
            if (!granded) {
                print("Denied")
            }
        }
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate, SendOngoingTaskDataToDescription {
    func didSendData(from task: Task) {
        taskId = task._id
        
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let currentTask = realmManager.localRealm?.objects(Task.self).filter("completed = false")
        
    }
    
}
