//
//  RemoveMobilUserToken.swift
//  Goglobal School
//
//  Created by loun sokphea on 30/6/23.
//

import Foundation

class RemoveMobilUserToken: ObservableObject {
    @Published var status: Bool = false
    @Published var message: String = ""
    
    func removeMobilUserToken(user: String, osType: String){
        Network2.shared.apollo.perform(mutation: RemoveMobilUserTokenMutation(user: user, osType: osType)){ [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let status = graphQLResult.data?.removeMobilUserToken.status {
                    DispatchQueue.main.async {
                        self?.status = status
                    }
                }
                if let message = graphQLResult.data?.removeMobilUserToken.message {
                    DispatchQueue.main.async {
                        self?.message = message
                    }
                }
            case .failure:
                print("Error RemoveMobilUserToken")
            }
        }
    }
}
