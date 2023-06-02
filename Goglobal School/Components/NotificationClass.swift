//
//  NotificationClass.swift
//  Goglobal School
//
//  Created by Macmini on 2/6/23.
//

import Foundation
import UserNotifications

class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    
    @Published var notificationCounter = 0
    @Published var show = false
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) {(_,_) in
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        self.show = true
        completionHandler([.badge, .banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "Okay" {
            self.show = true
            print("Hello")
            print("counter is " + String(notificationCounter))
            notificationCounter = notificationCounter + 1
            print("counter is now " + String(notificationCounter))
        }
        completionHandler()
    }
    
    func createNotification() {
        let content = UNMutableNotificationContent()
        content.title = "God of Posture"
        content.subtitle = "Straighten Your Neck"
        content.categoryIdentifier = "Actions"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
        let request = UNNotificationRequest(identifier: "In-App", content: content, trigger: trigger)
        
        //notification actions
        
        let close = UNNotificationAction(identifier: "Close", title: "Close", options: .destructive)
        let okay = UNNotificationAction(identifier: "Okay", title: "Okay", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "Actions", actions: [close, okay], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
