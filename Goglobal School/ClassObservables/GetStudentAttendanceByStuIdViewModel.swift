//
//  GetStudentAttendanceByStuIdViewModel.swift
//  Goglobal School
//
//  Created by Macmini on 22/4/23.
//

import Foundation

class GetStudentAttendanceByStuIdViewModel: ObservableObject {
    @Published var GetAllAttendance: [GetStudentAttendanceByStuIdModel] = []
    
    func getAllAttendance(studentId: String, limit: Int, startDate: String, endDate: String){
        Network.shared.apollo.fetch(query: GetStudentAttendanceByStuIdQuery(stuId: studentId, startDate: startDate, endDate: endDate, limit: limit)) { [weak self] result in
            switch result{
            case .success(let grahpQLResult):
                if let GetAllAttendance = grahpQLResult.data?.getStudentAttendanceByStuId {
                    self?.GetAllAttendance = GetAllAttendance.map(GetStudentAttendanceByStuIdModel.init)
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
    
    let GetAllStudentAttendance: GetStudentAttendanceByStuIdQuery.Data.GetStudentAttendanceByStuId?
    
    var id: String {
        GetAllStudentAttendance?._id ?? ""
    }
    
    var sectionShiftId: String {
        GetAllStudentAttendance?.sectionShiftId ?? ""
    }
    var attendanceDate: String {
        GetAllStudentAttendance?.attendanceDate ?? ""
    }
    
    var data: [GetDataModel] {
        GetAllStudentAttendance?.info?.map(GetDataModel.init) ?? []
    }

}

struct GetDataModel {

    let getData: GetStudentAttendanceByStuIdQuery.Data.GetStudentAttendanceByStuId.Info?

    var id: String {
        getData?.shiftId ?? ""
    }
    
    var status: String {
        getData?.status ?? ""
    }

    var morningCheckIn: String {
        getData?.morningCheckIn ?? ""
    }

    var morningCheckOut: String {
        getData?.morningCheckOut ?? ""
    }

    var afternoonCheckIn: String {
        getData?.afternoonCheckIn ?? ""
    }

    var afternoonCheckOut: String {
        getData?.afternoonCheckOut ?? ""
    }
}
