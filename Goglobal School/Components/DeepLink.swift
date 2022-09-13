//
//  DeepLink.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 10/9/22.
//

import Foundation

class AppDataModel: ObservableObject{
    @Published var currentSearch: DeepLink = .welcome
    
    func checkDeepLink(url: URL)-> Bool{
        guard let host = URLComponents(url: url, resolvingAgainstBaseURL: true)?.host else{
            return false
        }
        if host == DeepLink.welcome.rawValue{
            currentSearch = .welcome
        }else{
            return false
        }
        return true
    }
}
enum DeepLink: String{
    case welcome = "welcome"
}
