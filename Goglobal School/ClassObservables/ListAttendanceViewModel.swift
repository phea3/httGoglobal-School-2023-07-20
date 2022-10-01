//
//  ListAttendanceViewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import Foundation
import UserNotifications

class ListAttendanceViewModel: ObservableObject {
    
    @Published var Attendances: [AttendanceViewModel] = []
    @Published var Error: Bool = false
    func AlertUser(){
        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "It looks hungry"
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    func GetAllAttendance(studentId: String){
        Network.shared.apollo.fetch(query: GetAttendanceByStudentIdQuery(studentId: studentId)){ [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let Attendances = graphQLResult.data?.getAttendanceByStudentId{
                    DispatchQueue.main.async {
                        self?.Attendances = Attendances.map(AttendanceViewModel.init)
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
        self.Attendances = []
    }
}

struct AttendanceViewModel {
    let attendance: GetAttendanceByStudentIdQuery.Data.GetAttendanceByStudentId
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
