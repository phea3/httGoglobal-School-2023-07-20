//
//  UploadDeviceToken.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 14/10/22.
//

import Foundation

class UploadDeviceToken: ObservableObject {
    @Published var success: Bool = false
    @Published var Error: Bool = false
    @Published var message: String = ""
   
    func uploadToken(mobileUserId: String, newToken: TokenInput){
        Network.shared.apollo.perform(mutation: UpdateMobileTokenMutation(mobileUserId: mobileUserId, newToken: newToken )) { [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let success = graphQLResult.data?.updateMobileToken.success {
                    DispatchQueue.main.async {
                        self?.success = success
                    }
                }
                if let message = graphQLResult.data?.updateMobileToken.message {
                    DispatchQueue.main.async {
                        self?.message = message
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.Error = true
                }
            }
        }
    }
}

class ApiTokenSingleton
{
    static let shared = ApiTokenSingleton()
    
    @Published var token = (UserDefaults.standard.string(forKey: "DeviceToken") ?? "")
    
    func getToken() -> String {
        return token
    }
    
    func setToken(newToken: String) {
        DispatchQueue.main.async {
            self.token = newToken
        }
    }
}
