//
//  LoginViewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import Foundation
import KeychainSwift
import UserNotifications

class LoginViewModel: ObservableObject{
    
    @Published var isAuthenticated: Bool = UserDefaults.standard.bool(forKey: "isAuthenticated")
    @Published var userId: String = ""
    @Published var userprofileId: String = ""
    @Published var userName: String = ""
    @Published var userFirstname: String = ""
    @Published var userLastname: String = ""
    @Published var userTel: String = ""
    @Published var userNationality: String = ""
    @Published var userProfileImg: String = ""
    @Published var failLogin: Bool = false
    static var loginID = ""
    static var loginKeychainKey = ""
    
    // MARK: ASK Noti
    func AskUserForNotification(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("")
            } else if let error = error {
                print(error.localizedDescription)
                print("")
            }
        }
        
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "notification.aiff"))
    }
    
    // MARK: LogIn Button
    func login(email: String, password: String, checkState: Bool) {
        Network.shared.apollo.perform(mutation: LoginMutation(email: email, password: password)) { [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let errors = graphQLResult.errors{
                    print(errors)
                }
                if graphQLResult.data?.login?.token == nil {
                    DispatchQueue.main.async {
                        self?.failLogin = true
                    }
                }
                if let token = graphQLResult.data?.login?.token {
                    let keychain = KeychainSwift()
                    keychain.set(token, forKey: LoginViewModel.loginKeychainKey)
                    DispatchQueue.main.async {
                        self?.isAuthenticated = true
                        if checkState{
                            UserDefaults.standard.set(self?.isAuthenticated, forKey: "isAuthenticated")
                        }
//                        print(token)
                    }
                }
                if let userId = graphQLResult.data?.login?.user?.parentId?._id{
                    DispatchQueue.main.async {
                        self?.userId = userId
//                        print(self?.userId as Any)
                    }
                }
                if let userprofileId = graphQLResult.data?.login?.user?._id{
                    DispatchQueue.main.async {
                        self?.userprofileId = userprofileId
                    }
                }
                if let userName = graphQLResult.data?.login?.user?.parentId?.englishName{
                    DispatchQueue.main.async {
                        self?.userName = userName
                    }
                }
                if let userFirstname = graphQLResult.data?.login?.user?.parentId?.firstName{
                    DispatchQueue.main.async {
                        self?.userFirstname = userFirstname
                    }
                }
                if let userLastname = graphQLResult.data?.login?.user?.parentId?.lastName{
                    DispatchQueue.main.async {
                        self?.userLastname = userLastname
                    }
                }
                if let userTel =  graphQLResult.data?.login?.user?.parentId?.tel{
                    DispatchQueue.main.async {
                        self?.userTel = userTel
                    }
                }
                if let userNationality = graphQLResult.data?.login?.user?.parentId?.nationality{
                    DispatchQueue.main.async {
                        self?.userNationality = userNationality
                    }
                }
                if let userProfileImg = graphQLResult.data?.login?.user?.profileImage{
                    DispatchQueue.main.async {
                        self?.userProfileImg = userProfileImg
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: SignOut Button
    func signout() {
        let keychain = KeychainSwift()
        keychain.delete(LoginViewModel.loginKeychainKey)
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
}
