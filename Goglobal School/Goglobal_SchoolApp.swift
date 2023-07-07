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
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        _ = notification.request.content.userInfo
        return [[.banner, .badge, .sound]]
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        UIApplication.shared.applicationIconBadgeNumber = 0
        //        print("\(userInfo)")
        
        //        if let arrAPS = userInfo["aps"] as? [String: Any] {
        //            if let arrAlert = arrAPS["alert"] as? [String:Any] {
        //                let strTitle:String = arrAlert["title"] as? String ?? ""
        //                let strBody:String = arrAlert["body"] as? String ?? ""
        //                print(strTitle)
        //                print(strBody)
        //            }
        //        }
        
        //        if let arrGcm = userInfo["gcm.message_id"] as? String {
        //            print(arrGcm)
        //        }
        //google.c.fid
        //        if let arrGoogle = userInfo["google.c.fid"] as? String {
        //            print(arrGoogle)
        //        }
        
        //        if let arrSender = userInfo["google.c.sender.id"] as? String {
        //            print(arrSender)
        //        }
        //        if let arrCae = userInfo["google.c.a.e"] as? String {
        //            print(arrCae)
        //        }
        
        //        if let arrSrc = userInfo["stu_src"] as? String {
        //            print(arrSrc)
        //        }
        
        if let arrStuid = userInfo["stu_id"] as? String {
            //            print(arrStuid)
            AppState.shared.setStu_Id(stuId: arrStuid)
        }
        
        if let arrAction = userInfo["action"] as? String {
            //            print(arrAction)
            AppState.shared.setAction(action: arrAction)
        }
        
        if let arrStatus = userInfo["status"] as? String {
            //            print(arrStatus)
            AppState.shared.setStatus(status: arrStatus)
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
    -> UIBackgroundFetchResult {
        if let imageName = userInfo["image_name"] as? String {
            UIApplication.shared.setAlternateIconName(imageName) { error in
                if let error = error {
                    print("Error changing app icon: ", error.localizedDescription)
                }
            }
        }
        return UIBackgroundFetchResult.newData
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        //      print("Firebase registration token: \(String(describing: fcmToken))")
        ApiTokenSingleton.shared.setFCMToken(newFCMToken: fcmToken ?? "")
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
}
