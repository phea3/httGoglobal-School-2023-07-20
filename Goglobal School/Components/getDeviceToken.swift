//
//  getDeviceToken.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 5/10/22.
//

import Foundation

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
