//
//  GetStudenAttendancePermissionById.swift
//  Goglobal School
//
//  Created by Macmini on 25/4/23.
//

import Foundation

class GetStudenAttendancePermissionByIdViewModel: ObservableObject {
    @Published var GetAllPersmission: [GetStudenAttendancePermissionByIdModel] = []
    
    func getAllPermission(studentId: String, limit: Int){
        Network.shared.apollo.fetch(query: GetStudenAttendancePermissionByIdQuery(stuId: studentId, limit: limit)) { [weak self] result in
            switch result {
            case .success(let grahpQLResult):
                if let GetAllPermission = grahpQLResult.data?.getStudenAttendancePermissionById {
                    DispatchQueue.main.async {
                        self?.GetAllPersmission = GetAllPermission.map(GetStudenAttendancePermissionByIdModel.init)
                    }
                }
            case .failure(_):
                print("Error GetStudenAttendancePermissionById")
            }
        }
    }
}

struct GetStudenAttendancePermissionByIdModel {
    let getAllPermission: GetStudenAttendancePermissionByIdQuery.Data.GetStudenAttendancePermissionById?
    
    var id: String {
        getAllPermission?._id ?? ""
    }
    
    var startDate: String {
        getAllPermission?.startDate ?? ""
    }
    
    var endDate: String {
        getAllPermission?.endDate ?? ""
    }
    
    var requestDate: String {
        getAllPermission?.requestDate ?? ""
    }
    
    var reason: String {
        getAllPermission?.reason ?? ""
    }
    
    var shiftName: String {
        getAllPermission?.shiftId?.shiftName ?? ""
    }
}
