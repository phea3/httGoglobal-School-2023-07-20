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


