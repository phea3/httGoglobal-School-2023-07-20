//
//  ListAttendanceViewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import Foundation
import SwiftUI

class ListAttendanceViewModel: ObservableObject {
    
    @Published var Attendances: [AttendanceViewModel] = []
    @Published var Error: Bool = false
    
    // isSameMonth{
    func isEqual(dateN: Date,to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(dateN, equalTo: date, toGranularity: component)
    }
    func isInSameMonth(date: Date, dateM:Date) -> Bool { isEqual(dateN: dateM, to: date, toGranularity: .month) }
    //}
    
    func GetAllAttendance(studentId: String,sectionShiftId: String, currentDate: Date){
        Network.shared.apollo.fetch(query: GetAttendanceByStudentIdForMobileQuery(studentId: studentId, sectionShiftId: sectionShiftId)){ [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let Attendances = graphQLResult.data?.getAttendanceByStudentIdForMobile{
                    DispatchQueue.main.async {
                        self?.Attendances = self?.removeDuplicateElements(items: (Attendances.map(AttendanceViewModel.init)).filter({ att in
                            return Calendar.current.isDate( convertDate(inputDate: att.AttendanceDate), equalTo: currentDate, toGranularity: Calendar.Component.month)
                        })) ?? []
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.Error = true
                }
            }
        }
        
    }
    
    func clearCache(){
        Network.shared.apollo.clearCache()
    }
    func resetAttendance(){
        DispatchQueue.main.async {
            self.Attendances = []
        }
    }
    
    func removeDuplicateElements(items: [AttendanceViewModel]) -> [AttendanceViewModel] {
        var uniqueAtt = [AttendanceViewModel]()
        for item in items {
            if !uniqueAtt.contains(where: {$0.AttendanceDate == item.AttendanceDate }) {
                uniqueAtt.append(item)
            }
        }
        return uniqueAtt
    }
}

struct AttendanceViewModel {
    let attendance: GetAttendanceByStudentIdForMobileQuery.Data.GetAttendanceByStudentIdForMobile
    var AttendanceId: String {
        attendance.attendanceId!
    }
    var AttendanceDate: String {
        attendance.attendanceDate!
    }
    var Status: String {
        attendance.status!
    }
}

private func convertDate(inputDate: String) -> Date{
    let isoDate = inputDate
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = dateFormatter.date(from:isoDate)!
    return date
}

//stackoverflow for sample

extension Date {

    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }

    func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    func isInSameWeek(as date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }

    func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }

    var isInThisYear:  Bool { isInSameYear(as: Date()) }
    var isInThisMonth: Bool { isInSameMonth(as: Date()) }
    var isInThisWeek:  Bool { isInSameWeek(as: Date()) }

    var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    var isInToday:     Bool { Calendar.current.isDateInToday(self) }
    var isInTomorrow:  Bool { Calendar.current.isDateInTomorrow(self) }

    var isInTheFuture: Bool { self > Date() }
    var isInThePast:   Bool { self < Date() }
}

