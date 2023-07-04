//
//  AddMobilUserToken.swift
//  Goglobal School
//
//  Created by loun sokphea on 30/6/23.
//

import Foundation

class AddMobilUserToken: ObservableObject {
    @Published var status: Bool = false
    @Published var message: String = ""
    
    func addMobileUserToken(user: String, token: String, osType: String){
        Network2.shared.apollo.perform(mutation: AddMobilUserTokenMutation(user: user, token: token, osType: osType)){ [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let status = graphQLResult.data?.addMobilUserToken.status {
                    DispatchQueue.main.async {
                        self?.status = status
                    }
                }
                if let message = graphQLResult.data?.addMobilUserToken.message {
                    DispatchQueue.main.async {
                        self?.message = message
                    }
                }
            case .failure(let graphQLError):
                print(graphQLError.localizedDescription)
            }
        }
    }
}
