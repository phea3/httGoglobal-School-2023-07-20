//
//  ShowAvailableVersion.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 12/9/22.
//

import Foundation

class AppVersion {
    
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    static var appBuild: String {
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        return build ?? ""
    }
    let buildString = "Version: \(appVersion ?? "").\(appBuild )"
    let requestWithCountryURL = "https://itunes.apple.com/lookup?bundleId=Second-dayofSwift-Testing&country=855"
    

}
