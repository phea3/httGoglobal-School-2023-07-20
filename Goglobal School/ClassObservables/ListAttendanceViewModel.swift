//
//  ListAttendanceViewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import Foundation

class ListAttendanceViewModel: ObservableObject {
    
    @Published var Attendances: [AttendanceViewModel] = []
    @Published var Error: Bool = false
    
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
