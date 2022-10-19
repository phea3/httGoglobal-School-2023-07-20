//
//  MobileUserLogOutViewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 17/10/22.
//

import Foundation

class MobileUserLogOutViewModel: ObservableObject{
    @Published var success: Bool = false
    @Published var message: String = ""
    @Published var Error: Bool = false
    
    func MobileUserLogOut(mobileUserId: String, token: String){
        Network.shared.apollo.perform(mutation: MobileUserLogOutMutation(mobileUserId: mobileUserId, token: token)) { [weak self] result in
            switch result {
               
            case .success(let graphQLResult):
                if let success = graphQLResult.data?.mobileUserLogOut?.success {
                    DispatchQueue.main.async {
                        self?.success = success
                    }
                }
                if let message = graphQLResult.data?.mobileUserLogOut?.message {
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
