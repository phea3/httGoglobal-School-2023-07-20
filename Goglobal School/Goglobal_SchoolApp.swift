//
//  Goglobal_SchoolApp.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseMessaging
import UIKit
import UserNotifications
import FirebaseCore

@main
struct Goglobal_SchoolApp: App {
    @StateObject var appData: AppDataModel = AppDataModel()
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appData)
                .onOpenURL { url in
                    if appData.checkDeepLink(url: url){
                        print("FROM DEEP LINK")
                    }else{
                        print("FALL BACK DEEP LINK")
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
            FirebaseApp.configure()
        
            UNUserNotificationCenter.current().delegate = self
             
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
               options: authOptions,
               completionHandler: { _, _ in }
            )
        
           application.registerForRemoteNotifications()
           Messaging.messaging().delegate = self
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        ApiTokenSingleton.shared.setToken(newToken: token)
    };

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
       print(error.localizedDescription)
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification) async
    -> UNNotificationPresentationOptions {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // ...

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
        return [[.banner, .badge, .sound]]
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse) async {
    let userInfo = response.notification.request.content.userInfo

    // ...

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print full message.
    print(userInfo)
  }
    
    // Silent notifications
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
      -> UIBackgroundFetchResult {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print full message.
      print(userInfo)

      return UIBackgroundFetchResult.newData
    }
}


extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")
      
      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
}
