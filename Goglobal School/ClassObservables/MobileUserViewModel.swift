//
//  MobileUserViewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import Foundation

class MobileUserViewModel: ObservableObject{
    @Published var userID: String = ""
    @Published var userProfileImg: String = ""
    @Published var gmail: String = ""
    @Published var password: String = ""
    @Published var Error: Bool = false
    
    func getProfileImage(mobileUserId: String){
        Network.shared.apollo.fetch(query: GetMobileUserByIdQuery(mobileUserId: mobileUserId)){ [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let userID = graphQLResult.data?.getMobileUserById?._id{
                    DispatchQueue.main.async {
                        self?.userID = userID
                    }
                }
                if let userProfileImg = graphQLResult.data?.getMobileUserById?.profileImage{
                    DispatchQueue.main.async {
                        self?.userProfileImg = userProfileImg
                    }
                }
                if let email = graphQLResult.data?.getMobileUserById?.email{
                    DispatchQueue.main.async {
                        self?.gmail = email
                    }
                }
                if let password = graphQLResult.data?.getMobileUserById?.password{
                    DispatchQueue.main.async {
                        self?.password = password
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.Error = true
                }
            }
        }
    }
    
    func resetMobileUser(){
        self.userProfileImg = ""
    }
}


