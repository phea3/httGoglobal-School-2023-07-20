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

import Alamofire

class VersionCheck {

    public static let shared = VersionCheck()

    var newVersionAvailable: Bool?
    var appStoreVersion: String?
    var appLinkToAppStore: String?

    func checkAppStore(callback: ((_ versionAvailable: Bool?, _ version: String?, _ linking: String?)->Void)? = nil) {
        let ourBundleId = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
        AF.request("https://itunes.apple.com/lookup?bundleId=\(ourBundleId)").responseData { response in
            var isNew: Bool?
            var versionStr: String?
            var linker: String?
            switch response.result {
            case .success(let value):
                do {
                        let asJSON = try JSONSerialization.jsonObject(with: value)
                    if  let json = asJSON as? NSDictionary,
                        let results = json["results"] as? NSArray,
                        let entry = results.firstObject as? NSDictionary,
                        let appVersion = entry["version"] as? String,
                        let appLink = entry["trackViewUrl"] as? String,
                        let ourVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                    {
                        isNew = ourVersion < appVersion
                        versionStr = appVersion
                        linker = appLink
                     }
                    self.appStoreVersion = versionStr
                    self.newVersionAvailable = isNew
                    self.appLinkToAppStore = linker
                    callback?(isNew, versionStr, linker)
                               
                           } catch {
                               print("Error while decoding response:  from: iTune Apple")
                           }

            case .failure(let error):
                print(error)
            }
        }
    }
}
