//
//  ListViewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import Foundation

class ListViewModel: ObservableObject{
    // MARK: ALL Academic Views
    @Published var academicYear: [AcademicViewModel] = []
    @Published var Error: Bool = false
    var sortedAcademicYear: [AcademicViewModel]{
        get {
            academicYear.sorted(by: { $0.date < $1.date})
        }
        set{
            academicYear = newValue
        }
    }
    
    // MARK: Function Mapping All Events
    func populateAllContinent() {
        Network.shared.apollo.fetch(query: GetEventsQuery()) { [weak self] result in
            
            switch result{
            case .success(let GraphQLResutl):
                if let academicYear = GraphQLResutl.data?.getEvents {
                    DispatchQueue.main.async {
                        self?.academicYear = academicYear.map(AcademicViewModel.init)
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.Error = true
                }
            }
        }
    }
    func resetEvent(){
        self.academicYear = []
    }
    // MARK: Checking if the currentHour is task hour
    func isCurrentEvents(date: String)-> Bool{
        let isoDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let soDate = dateFormatter.date(from: isoDate)
        if soDate != nil{
            let isYes = NSCalendar.current.date(byAdding: .hour, value: -12, to: Date())
            return ( soDate! > isYes! )
        }else{
            return false
        }
    }
    // MARK: Func For Date Formatting
    public func convertDateFormat(inputDate: String) -> String {
        
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
            return newString
        }
        return "គ្មានកាលបរិច្ឆេទ"
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
}

