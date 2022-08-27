//
//  UpdateMobileUserProfileImg.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import Foundation

class UpdateMobileUserProfileImg: ObservableObject{
    
    @Published var success: Bool = false
    @Published var message: String = ""
    
    func uploadImg(mobileUserId: String, profileImage: String ){
        
        Network.shared.apollo.perform(mutation: UpdateMobileUserProfileImgMutation(mobileUserId: mobileUserId, profileImage: profileImage)){ [weak self] result in
            switch result{
            case .success(let graphQLResutl):
                if let success = graphQLResutl.data?.updateMobileUserProfileImg.success{
                    DispatchQueue.main.async {
                        self?.success = success
                    }
                }
                if let message = graphQLResutl.data?.updateMobileUserProfileImg.message{
                    self?.message = message
                  
                }
            case .failure(let graphQLError):
                print(graphQLError)
            }
        }
    }
}
