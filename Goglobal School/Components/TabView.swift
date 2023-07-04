//
//  TabView.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import Foundation

// MARK: Enum For Tabs with Rawnalue as Asset Image
enum Tab: String, CaseIterable{
    case dashboard = "Dashboard"
    case education = "Education"
    case bag = "Bag"
    case bus = "van"
    case book = "Book"
}

enum Chose: String, CaseIterable{
    case attendance = "Attendance"
    case absence = "Absence"
    case payment = "Payment"
    case score = "Score"
}

// Date Value Model...
struct DateValue: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
}

extension String {
    func localizedLanguage(language: String) -> String {
        if let bundlePath = Bundle.main.path(forResource: language, ofType: "lproj") {
            if let bundle = Bundle(path: bundlePath) {
                return bundle.localizedString(forKey: self, value: self, table: nil)
            }
        }
    
        return self
    }
}

