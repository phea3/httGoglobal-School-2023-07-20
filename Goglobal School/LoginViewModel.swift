//
//  LoginViewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import Foundation
import KeychainSwift

class LoginViewModel: ObservableObject{
    
    @Published var isAuthenticated: Bool = false
    @Published var userId: String = ""
    static var loginID = ""
    static var loginKeychainKey = "login"
    
    // MARK: LogIn Button
    func login(email: String, password: String) {
        
        Network.shared.apollo.perform(mutation: LoginMutation(email: email, password: password)) { [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let token = graphQLResult.data?.login?.token {
                    let keychain = KeychainSwift()
                    keychain.set(token, forKey: LoginViewModel.loginKeychainKey)
                    DispatchQueue.main.async {
                        self?.isAuthenticated = true
                        print(token)
                    }
                }
                if let userId = graphQLResult.data?.login?.user?.parentId?._id{
                    DispatchQueue.main.async {
                        self?.userId = userId
//                        print(userId)
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
