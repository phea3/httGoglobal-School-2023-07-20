//
//  DeleteNotificationByMobileUserId.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 18/10/22.
//

import Foundation

class DeleteNotificationByMobileUserIdViewModel: ObservableObject{
    @Published var success: Bool =  false
    @Published var Error: Bool = false
    @Published var ErrorWord: String = ""
    func DeleteNotificationByMobileUserId(mobileUserId: String){
        Network.shared.apollo.perform(mutation: DeleteNotificationByMobileUserIdMutation(mobileUserId: mobileUserId)){ [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let success = graphQLResult.data?.deleteNotificationByMobileUserId?.success {
                    DispatchQueue.main.async {
                        self?.success = success
                    }
                }
            case .failure(let graphQLError):
                DispatchQueue.main.async {
                    self?.Error = true
                    self?.ErrorWord = graphQLError.localizedDescription
                }
            }
        }
    }
}
