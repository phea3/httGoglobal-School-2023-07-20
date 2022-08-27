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
    
    func getProfileImage(){
        Network.shared.apollo.fetch(query: GetMobileUserByIdQuery(mobileUserId: "62da268e137c7e3a92e53a56")){ [weak self] result in
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
            case .failure(let graphQLError):
                print(graphQLError)
            }
            
        }
        
    }
}


