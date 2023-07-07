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

class AppState: ObservableObject {
    static let shared = AppState()
    @Published var stu_id : String?
    @Published var actionofnoty: String?
    @Published var status: String?
    
    func setStu_Id(stuId: String){
        DispatchQueue.main.async {
            self.stu_id = stuId
        }
    }
    func setStatus(status: String){
        DispatchQueue.main.async {
            self.status = status
        }
    }
    func getTab(status: String)-> Tab {
        if status == "true" {
            return .bus
        }
        return .dashboard
    }
    func getStudent()-> Bool {
        if stu_id == nil {
            return false
        } else {
            return true
        }
    }
    func setAction(action: String){
        DispatchQueue.main.async {
            self.actionofnoty = action
        }
    }
}
