//
//  ListViewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import Foundation
import SwiftUI

class ListViewModel: ObservableObject{
    
    // MARK: ALL Academic Views
    @Published var academicYear: [AcademicViewModel] = []
    @Published var academicYear2: [AcademicViewModel] = []
    @Published var activeYear: [activeAcademicYearModel] = []
    @Published var Error: Bool = false
    @Published var arrayStringObject = []
    @Published var academicYearId: String = ""
    @Published var academicYearName: String = ""
    
    let isYes = NSCalendar.current.date(byAdding: .hour, value: -12, to: Date())
    
    var khmerYear: String{
        get {
            academicYearName == "2023-2024" ? "២០២៣~២០២៤" : academicYearName == "2022-2023" ? "២០២២~២០២៣" : academicYearName == "2021-2022" ? "២០២១~២០២២" : "២០២១~២០២២"
        }set{
            academicYearName = newValue
        }
    }
    
    var sortedAcademicYear: [AcademicViewModel]{
        get {
            academicYear.sorted(by: { $0.date < $1.date})
        }
        set{
            academicYear = newValue
        }
    }
    
    var removeExpireDate: [AcademicViewModel]{
       
        get {
            sortedAcademicYear.filter{ isCurrentEvents(date: $0.date) > isYes! }
        }set{
            sortedAcademicYear = newValue
        }
    }
    
    func clearCache(){
        Network.shared.apollo.clearCache()
    }
    
    // MARK: Function Mapping All Events
    func populateAllContinent(academicYearId: String) {
        Network.shared.apollo.fetch(query: GetEventsQuery(academicYearId: academicYearId)) { [weak self] result in
            
            switch result{
            case .success(let GraphQLResutl):
                if let academicYear = GraphQLResutl.data?.getEvents {
                    DispatchQueue.main.async {
                        self?.academicYear = academicYear.map(AcademicViewModel.init)
                        self?.academicYear2 = academicYear.map(AcademicViewModel.init)
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.Error = true
                }
            }
        }
    }
    
    func activeAcademicYear(){
        Network.shared.apollo.fetch(query: GetActiveAcademicYearQuery()){ [weak self] result in
            switch result{
            case .success(let grahpQLResult):
                if let activeYear = grahpQLResult.data?.getActiveAcademicYear{
                    self?.activeYear = activeYear.map(activeAcademicYearModel.init)
                }
                if let firstElement = self?.activeYear.first {
                    DispatchQueue.main.async {
                        self?.academicYearId = firstElement.id
                        self?.academicYearName = firstElement.activeYearName
                    }
                }
            case .failure(let graphQLError):
                print(graphQLError)
            }
        }
    }
    
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }

        var tempDate = from
        var array = [tempDate]

        while tempDate < to {
            tempDate = NSCalendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        return array
    }
    
    func resetEvent(){
        self.academicYear = []
    }
    
    // MARK: Checking if the currentHour is task hour
    func isCurrentEvents(date: String)-> Date{
        let isoDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: isoDate) ?? Date()
//        if soDate != nil{
//            let isYes = NSCalendar.current.date(byAdding: .hour, value: -12, to: Date())
//            let isNo = NSCalendar.current.date(byAdding: .day, value: 30, to: Date())
//            return ( (soDate! > isYes!) &&  (soDate! < isNo!) )
//        }else{
//            return false
//        }
    }
    public func convertDateFormaterForEnglish(inputDate: String, inputAnotherDate: String) -> String{
        if (inputDate == inputAnotherDate) {
            let isoDate = inputDate
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from:isoDate)
            
            if date != nil{
                let StringFormatter =  DateFormatter()
                StringFormatter.locale = Locale(identifier: "en_US_POSIX")
                StringFormatter.dateFormat = "d, MMMM yyyy"
                
                let blue = StringFormatter.string(from: date!)
                
                let aString = blue
                
                return aString
            }
            return "គ្មានកាលបរិច្ឆេទ"
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date1 = dateFormatter.date(from: inputDate)
            let date2 = dateFormatter.date(from: inputAnotherDate)
            if (date1 != nil) || date2 != nil {
                let StringFormatter1 =  DateFormatter()
                let StringFormatter2 =  DateFormatter()
                StringFormatter1.locale = Locale(identifier: "en_US_POSIX")
                StringFormatter2.locale = Locale(identifier: "en_US_POSIX")
                StringFormatter1.dateFormat = "d"
                StringFormatter2.dateFormat = " MMMM yyyy"
                let blue1 = StringFormatter1.string(from: date1!)
                let blue3 = StringFormatter2.string(from: date1!)
                let blue2 = StringFormatter1.string(from: date2!)
                let aString = "\(blue1) ~ \(blue2), \(blue3)"
                
                return aString
            }
            return "គ្មានកាលបរិច្ឆេទ"
        }
    }
    // MARK: Func For Date Formatting
        public func convertDateFormater(inputDate: String, inputAnotherDate: String) -> String {
            if (inputDate == inputAnotherDate) {
                
                let isoDate = inputDate
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                let date = dateFormatter.date(from:isoDate)
                
                if date != nil{
                    let StringFormatter =  DateFormatter()
                    StringFormatter.locale = Locale(identifier: "en_US_POSIX")
                    StringFormatter.dateFormat = "d, MMM yyyy"
                    
                    let blue = StringFormatter.string(from: date!)
                    
                    let aString = blue
                    var newString = aString.replacingOccurrences(of:"Jun", with: "មិថុនា", options: .literal, range: nil)
                    
                    if blue.contains("Jan"){
                        newString = aString.replacingOccurrences(of: "Jan", with: "មករា", options: .literal, range: nil)
                    } else if blue.contains("Feb") {
                        newString = aString.replacingOccurrences(of: "Feb", with: "កុម្ភះ", options: .literal, range: nil)
                    } else if blue.contains("Mar") {
                        newString = aString.replacingOccurrences(of: "Mar", with: "មិនា", options: .literal, range: nil)
                    }  else if blue.contains("Apr") {
                        newString = aString.replacingOccurrences(of: "Apr", with: "មេសា", options: .literal, range: nil)
                    } else if blue.contains("May") {
                        newString = aString.replacingOccurrences(of: "May", with: "ឧសភា", options: .literal, range: nil)
                    } else if blue.contains("Jun") {
                        newString = aString.replacingOccurrences(of: "Jun", with: "មិថុនា", options: .literal, range: nil)
                    }else if blue.contains("Jul") {
                        newString = aString.replacingOccurrences(of: "Jul", with: "កក្កដា", options: .literal, range: nil)
                    }else if blue.contains("Aug") {
                        newString = aString.replacingOccurrences(of: "Aug", with: "សីហា", options: .literal, range: nil)
                    }else if blue.contains("Sep") {
                        newString = aString.replacingOccurrences(of: "Sep", with: "កញ្ញា", options: .literal, range: nil)
                    }else if blue.contains("Oct") {
                        newString = aString.replacingOccurrences(of: "Oct", with: "តុលា", options: .literal, range: nil)
                    }else if blue.contains("Nov") {
                        newString = aString.replacingOccurrences(of: "Nov", with: "វិច្ចិកា", options: .literal, range: nil)
                    }else if blue.contains("Dec") {
                        newString = aString.replacingOccurrences(of: "Dec", with: "ធ្នូ", options: .literal, range: nil)
                    }
                    let newStringDays = newString
                                            .replacingOccurrences(of: "0", with: "០", options: .literal, range: nil)
                                            .replacingOccurrences(of: "1", with: "១", options: .literal, range: nil)
                                            .replacingOccurrences(of: "2", with: "២", options: .literal, range: nil)
                                            .replacingOccurrences(of: "3", with: "៣", options: .literal, range: nil)
                                            .replacingOccurrences(of: "4", with: "៤", options: .literal, range: nil)
                                            .replacingOccurrences(of: "5", with: "៥", options: .literal, range: nil)
                                            .replacingOccurrences(of: "6", with: "៦", options: .literal, range: nil)
                                            .replacingOccurrences(of: "7", with: "៧", options: .literal, range: nil)
                                            .replacingOccurrences(of: "8", with: "៨", options: .literal, range: nil)
                                            .replacingOccurrences(of: "9", with: "៩", options: .literal, range: nil)
                                            .replacingOccurrences(of: "10", with: "១០", options: .literal, range: nil)
                                            .replacingOccurrences(of: "11", with: "១១", options: .literal, range: nil)
                                            .replacingOccurrences(of: "12", with: "១២", options: .literal, range: nil)
                                            .replacingOccurrences(of: "13", with: "១៣", options: .literal, range: nil)
                                            .replacingOccurrences(of: "14", with: "១៤", options: .literal, range: nil)
                                            .replacingOccurrences(of: "15", with: "១៥", options: .literal, range: nil)
                                            .replacingOccurrences(of: "16", with: "១៦", options: .literal, range: nil)
                                            .replacingOccurrences(of: "17", with: "១៧", options: .literal, range: nil)
                                            .replacingOccurrences(of: "18", with: "១៨", options: .literal, range: nil)
                                            .replacingOccurrences(of: "19", with: "១៩", options: .literal, range: nil)
                                            .replacingOccurrences(of: "20", with: "២០", options: .literal, range: nil)
                                            .replacingOccurrences(of: "21", with: "២១", options: .literal, range: nil)
                                            .replacingOccurrences(of: "22", with: "២២", options: .literal, range: nil)
                                            .replacingOccurrences(of: "23", with: "២៣", options: .literal, range: nil)
                                            .replacingOccurrences(of: "24", with: "២៤", options: .literal, range: nil)
                                            .replacingOccurrences(of: "25", with: "២៥", options: .literal, range: nil)
                                            .replacingOccurrences(of: "26", with: "២៦", options: .literal, range: nil)
                                            .replacingOccurrences(of: "27", with: "២៧", options: .literal, range: nil)
                                            .replacingOccurrences(of: "28", with: "២៨", options: .literal, range: nil)
                                            .replacingOccurrences(of: "29", with: "២៩", options: .literal, range: nil)
                                            .replacingOccurrences(of: "30", with: "៣០", options: .literal, range: nil)
                                            .replacingOccurrences(of: "31", with: "៣១", options: .literal, range: nil)
                
                    return newStringDays
                    
                }
                return "គ្មានកាលបរិច្ឆេទ"
            }else{
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                let date1 = dateFormatter.date(from: inputDate)
                let date2 = dateFormatter.date(from: inputAnotherDate)
                if (date1 != nil) || date2 != nil {
                    let StringFormatter1 =  DateFormatter()
                    let StringFormatter2 =  DateFormatter()
                    StringFormatter1.locale = Locale(identifier: "en_US_POSIX")
                    StringFormatter2.locale = Locale(identifier: "en_US_POSIX")
                    StringFormatter1.dateFormat = "d"
                    StringFormatter2.dateFormat = " MMM yyyy"
                    let blue1 = StringFormatter1.string(from: date1!)
                    let blue3 = StringFormatter2.string(from: date1!)
                    let blue2 = StringFormatter1.string(from: date2!)
                    let aString = "\(blue1) ~ \(blue2), \(blue3)"
                    var newString = aString.replacingOccurrences(of:"Jun", with: "មិថុនា", options: .literal, range: nil)
                    
                    if aString.contains("Jan"){
                        newString = aString.replacingOccurrences(of: "Jan", with: "មករា", options: .literal, range: nil)
                    } else if aString.contains("Feb") {
                        newString = aString.replacingOccurrences(of: "Feb", with: "កុម្ភះ", options: .literal, range: nil)
                    } else if aString.contains("Mar") {
                        newString = aString.replacingOccurrences(of: "Mar", with: "មិនា", options: .literal, range: nil)
                    }  else if aString.contains("Apr") {
                        newString = aString.replacingOccurrences(of: "Apr", with: "មេសា", options: .literal, range: nil)
                    } else if aString.contains("May") {
                        newString = aString.replacingOccurrences(of: "May", with: "ឧសភា", options: .literal, range: nil)
                    } else if aString.contains("Jun") {
                        newString = aString.replacingOccurrences(of: "Jun", with: "មិថុនា", options: .literal, range: nil)
                    }else if aString.contains("Jul") {
                        newString = aString.replacingOccurrences(of: "Jul", with: "កក្កដា", options: .literal, range: nil)
                    }else if aString.contains("Aug") {
                        newString = aString.replacingOccurrences(of: "Aug", with: "សីហា", options: .literal, range: nil)
                    }else if aString.contains("Sep") {
                        newString = aString.replacingOccurrences(of: "Sep", with: "កញ្ញា", options: .literal, range: nil)
                    }else if aString.contains("Oct") {
                        newString = aString.replacingOccurrences(of: "Oct", with: "តុលា", options: .literal, range: nil)
                    }else if aString.contains("Nov") {
                        newString = aString.replacingOccurrences(of: "Nov", with: "វិច្ចិកា", options: .literal, range: nil)
                    }else if aString.contains("Dec") {
                        newString = aString.replacingOccurrences(of: "Dec", with: "ធ្នូ", options: .literal, range: nil)
                    }
                    let newStringYear = newString
                                            .replacingOccurrences(of: "0", with: "០", options: .literal, range: nil)
                                            .replacingOccurrences(of: "1", with: "១", options: .literal, range: nil)
                                            .replacingOccurrences(of: "2", with: "២", options: .literal, range: nil)
                                            .replacingOccurrences(of: "3", with: "៣", options: .literal, range: nil)
                                            .replacingOccurrences(of: "4", with: "៤", options: .literal, range: nil)
                                            .replacingOccurrences(of: "5", with: "៥", options: .literal, range: nil)
                                            .replacingOccurrences(of: "6", with: "៦", options: .literal, range: nil)
                                            .replacingOccurrences(of: "7", with: "៧", options: .literal, range: nil)
                                            .replacingOccurrences(of: "8", with: "៨", options: .literal, range: nil)
                                            .replacingOccurrences(of: "9", with: "៩", options: .literal, range: nil)
                                            .replacingOccurrences(of: "10", with: "១០", options: .literal, range: nil)
                                            .replacingOccurrences(of: "11", with: "១១", options: .literal, range: nil)
                                            .replacingOccurrences(of: "12", with: "១២", options: .literal, range: nil)
                                            .replacingOccurrences(of: "13", with: "១៣", options: .literal, range: nil)
                                            .replacingOccurrences(of: "14", with: "១៤", options: .literal, range: nil)
                                            .replacingOccurrences(of: "15", with: "១៥", options: .literal, range: nil)
                                            .replacingOccurrences(of: "16", with: "១៦", options: .literal, range: nil)
                                            .replacingOccurrences(of: "17", with: "១៧", options: .literal, range: nil)
                                            .replacingOccurrences(of: "18", with: "១៨", options: .literal, range: nil)
                                            .replacingOccurrences(of: "19", with: "១៩", options: .literal, range: nil)
                                            .replacingOccurrences(of: "20", with: "២០", options: .literal, range: nil)
                                            .replacingOccurrences(of: "21", with: "២១", options: .literal, range: nil)
                                            .replacingOccurrences(of: "22", with: "២២", options: .literal, range: nil)
                                            .replacingOccurrences(of: "23", with: "២៣", options: .literal, range: nil)
                                            .replacingOccurrences(of: "24", with: "២៤", options: .literal, range: nil)
                                            .replacingOccurrences(of: "25", with: "២៥", options: .literal, range: nil)
                                            .replacingOccurrences(of: "26", with: "២៦", options: .literal, range: nil)
                                            .replacingOccurrences(of: "27", with: "២៧", options: .literal, range: nil)
                                            .replacingOccurrences(of: "28", with: "២៨", options: .literal, range: nil)
                                            .replacingOccurrences(of: "29", with: "២៩", options: .literal, range: nil)
                                            .replacingOccurrences(of: "30", with: "៣០", options: .literal, range: nil)
                                            .replacingOccurrences(of: "31", with: "៣១", options: .literal, range: nil)
                    
                    return newStringYear
                }
                return "គ្មានកាលបរិច្ឆេទ"
            }
        }
    public func convertDateFormatToEnglish(inputDate: String, inputAnotherDate: String) -> [String] {
        if !(inputDate == inputAnotherDate) {
            let calendar = NSCalendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date1 = dateFormatter.date(from: inputDate)
            let date2 = dateFormatter.date(from: inputAnotherDate)
            if date1 != nil {
                let result1 = calendar.startOfDay(for: date1!)
                let result2 = calendar.startOfDay(for: date2!)
                
                let components = calendar.dateComponents([.day], from: result1, to: result2).day
                let nextDays = calendar.date(byAdding: .day, value: components ?? 0, to: result1)!
                
                let myRange = datesRange(from: result1, to: nextDays)
                dateFormatter.dateFormat = "d, MMMM yyyy"
                
                let finals = myRange.map{
                    dateFormatter.string(from: $0)
                }
               
                return finals
            }
            return ["គ្មានកាលបរិច្ឆេទ"]
        }else{
            let isoDate = inputDate
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from:isoDate)
            if date != nil{
                let StringFormatter =  DateFormatter()
                StringFormatter.locale = Locale(identifier: "en_US_POSIX")
                StringFormatter.dateFormat = "d, MMMM yyyy"
                
                let blue = StringFormatter.string(from: date!)
                
                let aString = blue
                return [aString]
            }
            return ["គ្មានកាលបរិច្ឆេទ"]
        }
    }
    // MARK: Func For Date Formatting
    public func convertDateFormat(inputDate: String, inputAnotherDate: String) -> [String] {
        if !(inputDate == inputAnotherDate) {
            let calendar = NSCalendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date1 = dateFormatter.date(from: inputDate)
            let date2 = dateFormatter.date(from: inputAnotherDate)
            if date1 != nil {
                let result1 = calendar.startOfDay(for: date1!)
                let result2 = calendar.startOfDay(for: date2!)
                
                let components = calendar.dateComponents([.day], from: result1, to: result2).day
                let nextDays = calendar.date(byAdding: .day, value: components ?? 0, to: result1)!
                
                let myRange = datesRange(from: result1, to: nextDays)
                dateFormatter.dateFormat = "d, MMM yyyy"
                let finals = myRange.map{
                    dateFormatter.string(from: $0)
                }
                let results = finals.map({
                        $0
                        .replacingOccurrences(of: "Jan", with: "មករា", options: .literal, range: nil)
                        .replacingOccurrences(of: "Feb", with: "កុម្ភះ", options: .literal, range: nil)
                        .replacingOccurrences(of: "Mar", with: "មិនា", options: .literal, range: nil)
                        .replacingOccurrences(of: "Apr", with: "មេសា", options: .literal, range: nil)
                        .replacingOccurrences(of: "May", with: "ឧសភា", options: .literal, range: nil)
                        .replacingOccurrences(of: "Jun", with: "មិថុនា", options: .literal, range: nil)
                        .replacingOccurrences(of: "Jul", with: "កក្កដា", options: .literal, range: nil)
                        .replacingOccurrences(of: "Aug", with: "សីហា", options: .literal, range: nil)
                        .replacingOccurrences(of: "Sep", with: "កញ្ញា", options: .literal, range: nil)
                        .replacingOccurrences(of: "Oct", with: "តុលា", options: .literal, range: nil)
                        .replacingOccurrences(of: "Nov", with: "វិច្ចិកា", options: .literal, range: nil)
                        .replacingOccurrences(of: "Dec", with: "ធ្នូ", options: .literal, range: nil)
                        .replacingOccurrences(of: "0", with: "០", options: .literal, range: nil)
                        .replacingOccurrences(of: "1", with: "១", options: .literal, range: nil)
                        .replacingOccurrences(of: "2", with: "២", options: .literal, range: nil)
                        .replacingOccurrences(of: "3", with: "៣", options: .literal, range: nil)
                        .replacingOccurrences(of: "4", with: "៤", options: .literal, range: nil)
                        .replacingOccurrences(of: "5", with: "៥", options: .literal, range: nil)
                        .replacingOccurrences(of: "6", with: "៦", options: .literal, range: nil)
                        .replacingOccurrences(of: "7", with: "៧", options: .literal, range: nil)
                        .replacingOccurrences(of: "8", with: "៨", options: .literal, range: nil)
                        .replacingOccurrences(of: "9", with: "៩", options: .literal, range: nil)
                        .replacingOccurrences(of: "10", with: "១០", options: .literal, range: nil)
                        .replacingOccurrences(of: "11", with: "១១", options: .literal, range: nil)
                        .replacingOccurrences(of: "12", with: "១២", options: .literal, range: nil)
                        .replacingOccurrences(of: "13", with: "១៣", options: .literal, range: nil)
                        .replacingOccurrences(of: "14", with: "១៤", options: .literal, range: nil)
                        .replacingOccurrences(of: "15", with: "១៥", options: .literal, range: nil)
                        .replacingOccurrences(of: "16", with: "១៦", options: .literal, range: nil)
                        .replacingOccurrences(of: "17", with: "១៧", options: .literal, range: nil)
                        .replacingOccurrences(of: "18", with: "១៨", options: .literal, range: nil)
                        .replacingOccurrences(of: "19", with: "១៩", options: .literal, range: nil)
                        .replacingOccurrences(of: "20", with: "២០", options: .literal, range: nil)
                        .replacingOccurrences(of: "21", with: "២១", options: .literal, range: nil)
                        .replacingOccurrences(of: "22", with: "២២", options: .literal, range: nil)
                        .replacingOccurrences(of: "23", with: "២៣", options: .literal, range: nil)
                        .replacingOccurrences(of: "24", with: "២៤", options: .literal, range: nil)
                        .replacingOccurrences(of: "25", with: "២៥", options: .literal, range: nil)
                        .replacingOccurrences(of: "26", with: "២៦", options: .literal, range: nil)
                        .replacingOccurrences(of: "27", with: "២៧", options: .literal, range: nil)
                        .replacingOccurrences(of: "28", with: "២៨", options: .literal, range: nil)
                        .replacingOccurrences(of: "29", with: "២៩", options: .literal, range: nil)
                        .replacingOccurrences(of: "30", with: "៣០", options: .literal, range: nil)
                        .replacingOccurrences(of: "31", with: "៣១", options: .literal, range: nil)
                })
                return results
            }
            return ["គ្មានកាលបរិច្ឆេទ"]
        }else{
            let isoDate = inputDate
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from:isoDate)
            if date != nil{
                let StringFormatter =  DateFormatter()
                StringFormatter.locale = Locale(identifier: "en_US_POSIX")
                StringFormatter.dateFormat = "d, MMM yyyy"
                
                let blue = StringFormatter.string(from: date!)
                
                let aString = blue
                var newString = aString.replacingOccurrences(of:"Jun", with: "មិថុនា", options: .literal, range: nil)
                
                if blue.contains("Jan"){
                    newString = aString.replacingOccurrences(of: "Jan", with: "មករា", options: .literal, range: nil)
                } else if blue.contains("Feb") {
                    newString = aString.replacingOccurrences(of: "Feb", with: "កុម្ភះ", options: .literal, range: nil)
                } else if blue.contains("Mar") {
                    newString = aString.replacingOccurrences(of: "Mar", with: "មិនា", options: .literal, range: nil)
                }  else if blue.contains("Apr") {
                    newString = aString.replacingOccurrences(of: "Apr", with: "មេសា", options: .literal, range: nil)
                } else if blue.contains("May") {
                    newString = aString.replacingOccurrences(of: "May", with: "ឧសភា", options: .literal, range: nil)
                } else if blue.contains("Jun") {
                    newString = aString.replacingOccurrences(of: "Jun", with: "មិថុនា", options: .literal, range: nil)
                }else if blue.contains("Jul") {
                    newString = aString.replacingOccurrences(of: "Jul", with: "កក្កដា", options: .literal, range: nil)
                }else if blue.contains("Aug") {
                    newString = aString.replacingOccurrences(of: "Aug", with: "សីហា", options: .literal, range: nil)
                }else if blue.contains("Sep") {
                    newString = aString.replacingOccurrences(of: "Sep", with: "កញ្ញា", options: .literal, range: nil)
                }else if blue.contains("Oct") {
                    newString = aString.replacingOccurrences(of: "Oct", with: "តុលា", options: .literal, range: nil)
                }else if blue.contains("Nov") {
                    newString = aString.replacingOccurrences(of: "Nov", with: "វិច្ចិកា", options: .literal, range: nil)
                }else if blue.contains("Dec") {
                    newString = aString.replacingOccurrences(of: "Dec", with: "ធ្នូ", options: .literal, range: nil)
                }
                
                let newStringDays = newString
                            .replacingOccurrences(of: "0", with: "០", options: .literal, range: nil)
                            .replacingOccurrences(of: "1", with: "១", options: .literal, range: nil)
                            .replacingOccurrences(of: "2", with: "២", options: .literal, range: nil)
                            .replacingOccurrences(of: "3", with: "៣", options: .literal, range: nil)
                            .replacingOccurrences(of: "4", with: "៤", options: .literal, range: nil)
                            .replacingOccurrences(of: "5", with: "៥", options: .literal, range: nil)
                            .replacingOccurrences(of: "6", with: "៦", options: .literal, range: nil)
                            .replacingOccurrences(of: "7", with: "៧", options: .literal, range: nil)
                            .replacingOccurrences(of: "8", with: "៨", options: .literal, range: nil)
                            .replacingOccurrences(of: "9", with: "៩", options: .literal, range: nil)
                            .replacingOccurrences(of: "10", with: "១០", options: .literal, range: nil)
                            .replacingOccurrences(of: "11", with: "១១", options: .literal, range: nil)
                            .replacingOccurrences(of: "12", with: "១២", options: .literal, range: nil)
                            .replacingOccurrences(of: "13", with: "១៣", options: .literal, range: nil)
                            .replacingOccurrences(of: "14", with: "១៤", options: .literal, range: nil)
                            .replacingOccurrences(of: "15", with: "១៥", options: .literal, range: nil)
                            .replacingOccurrences(of: "16", with: "១៦", options: .literal, range: nil)
                            .replacingOccurrences(of: "17", with: "១៧", options: .literal, range: nil)
                            .replacingOccurrences(of: "18", with: "១៨", options: .literal, range: nil)
                            .replacingOccurrences(of: "19", with: "១៩", options: .literal, range: nil)
                            .replacingOccurrences(of: "20", with: "២០", options: .literal, range: nil)
                            .replacingOccurrences(of: "21", with: "២១", options: .literal, range: nil)
                            .replacingOccurrences(of: "22", with: "២២", options: .literal, range: nil)
                            .replacingOccurrences(of: "23", with: "២៣", options: .literal, range: nil)
                            .replacingOccurrences(of: "24", with: "២៤", options: .literal, range: nil)
                            .replacingOccurrences(of: "25", with: "២៥", options: .literal, range: nil)
                            .replacingOccurrences(of: "26", with: "២៦", options: .literal, range: nil)
                            .replacingOccurrences(of: "27", with: "២៧", options: .literal, range: nil)
                            .replacingOccurrences(of: "28", with: "២៨", options: .literal, range: nil)
                            .replacingOccurrences(of: "29", with: "២៩", options: .literal, range: nil)
                            .replacingOccurrences(of: "30", with: "៣០", options: .literal, range: nil)
                            .replacingOccurrences(of: "31", with: "៣១", options: .literal, range: nil)
                
                return [newStringDays]
            }
            return ["គ្មានកាលបរិច្ឆេទ"]
        }
    }
}

struct AcademicViewModel {
    
    let academic: GetEventsQuery.Data.GetEvent
    
    var code: String {
        academic._id ?? ""
    }
    
    var eventname: String {
        academic.eventName ?? ""
    }
    
    var date: String {
        academic.eventDate ?? ""
    }
    
    var eventnameKhmer: String {
        academic.eventNameKhmer ?? ""
    }
    var enddate: String{
        academic.endEventDate ?? ""
    }
    var academicyear: AcademinYear {
        academic.academicYearId.map(AcademinYear.init) ?? AcademinYear(academicyear: academic.academicYearId)
    }
}

struct AcademinYear{
    let academicyear: GetEventsQuery.Data.GetEvent.AcademicYearId?
    var id: String{
        academicyear?._id ?? ""
    }
    var year: String{
        academicyear?.academicYear ?? ""
    }
}

struct activeAcademicYearModel {
    let active: GetActiveAcademicYearQuery.Data.GetActiveAcademicYear?
    var id: String{
        active?._id ?? ""
    }
    var activeYearName: String{
        active?.academicYear ?? ""
    }
}
