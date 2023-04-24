//
//  GetStudentAttendanceByStuIdViewModel.swift
//  Goglobal School
//
//  Created by Macmini on 22/4/23.
//

import Foundation

class GetStudentAttendanceByStuIdViewModel: ObservableObject {
    @Published var GetAllAttendance: [GetStudentAttendanceByStuIdModel] = []
    @Published var attendanceDate: Date = Date()
    @Published var academicYearId: String = ""
    @Published var academicYearName: String = ""
    
    func getAllAttendance(studentId: String){
        Network.shared.apollo.fetch(query: GetStudentAttendanceByStuIdQuery(stuId: "61f10ab7ac29959fd062be91")) { [weak self] result in
            switch result{
            case .success(let grahpQLResult):
                if let GetAllAttendance = grahpQLResult.data?.getStudentAttendanceByStuId?.data {
                    self?.GetAllAttendance = GetAllAttendance.map(GetStudentAttendanceByStuIdModel.init)
                    print(self?.GetAllAttendance as Any)
                }
                
                if let attendanceDate = grahpQLResult.data?.getStudentAttendanceByStuId?.attendanceDate {
                    self?.attendanceDate = self?.convertDate(inputDate: attendanceDate) ?? Date()
                }
                if let academicYearId = grahpQLResult.data?.getStudentAttendanceByStuId?.academicYearId?._id {
                    self?.academicYearId = academicYearId
                }
            case .failure(_):
                print("GetStudentAttendanceByStuIdModel is error")
            }
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
}

struct GetStudentAttendanceByStuIdModel{
    let GetAllStudentAttendance: GetStudentAttendanceByStuIdQuery.Data.GetStudentAttendanceByStuId.Datum?
    
    var id: String {
        GetAllStudentAttendance?._id ?? ""
    }
    var remark: String {
        GetAllStudentAttendance?.remark ?? ""
    }
    
    var status: String {
        GetAllStudentAttendance?.status ?? ""
    }
    
    var morningCheckIn: String {
        GetAllStudentAttendance?.morning?.checkIn ?? ""
    }
    
    var morningCheckOut: String {
        GetAllStudentAttendance?.morning?.checkOut ?? ""
    }
    
    var afternoonCheckIn: String {
        GetAllStudentAttendance?.afternoon?.checkIn ?? ""
    }
    
    var afternoonCheckOut: String {
        GetAllStudentAttendance?.afternoon?.checkOut ?? ""
    }
}
