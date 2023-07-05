//
//  UploadDeviceToken.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 14/10/22.
//

import Foundation

class ApiTokenSingleton {
    static let shared = ApiTokenSingleton()
    
    @Published var token = (UserDefaults.standard.string(forKey: "DeviceToken") ?? "")
    @Published var FCM_token = ""
    func getToken() -> String {
        return token
    }
   
    func getFCMToken() -> String {
        return FCM_token
    }
    
    func setToken(newToken: String) {
        DispatchQueue.main.async {
            self.token = newToken
        }
    }
    
    func setFCMToken(newFCMToken: String) {
        DispatchQueue.main.async {
            self.FCM_token = newFCMToken
        }
    }
}
