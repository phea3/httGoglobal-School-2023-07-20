//
//  GetStudentTransportationAttendancePagination.swift
//  Goglobal School
//
//  Created by loun sokphea on 4/7/23.
//

import Foundation

class GetStudentTransportationAttendancePagination: ObservableObject {
    @Published var attendances: [GetStudentTransportationAttendancePaginationModel] = []
    
    func getAttendances(page: Int, limit: Int, start: String, end: String, busId: String, studentId: String){
        Network2.shared.apollo.fetch(query: GetStudentTransportationAttendancePaginationQuery(page: page, limit: limit, start: start, end: end, busId: busId, studentId: studentId)){ [weak self] result in
            switch result{
                
            case .success(let graphqlresult):
                if let attendances = graphqlresult.data?.getStudentTransportationAttendancePagination.data {
                    self?.attendances = attendances.map(GetStudentTransportationAttendancePaginationModel.init)
                    //                    print(self?.attendances as Any)
                }
            case .failure(_):
                print("GetStudentTransportationAttendancePaginationModel ERROR")
            }
        }
    }
    struct GetStudentTransportationAttendancePaginationModel {
        let attendance: GetStudentTransportationAttendancePaginationQuery.Data.GetStudentTransportationAttendancePagination.Datum?
        
        var id: String {
            attendance?._id ?? ""
        }
        
        var date: String {
            attendance?.date ?? ""
        }
        
        var checkIn: String {
            attendance?.checkIn ?? ""
        }
        
        var checkOut: String {
            attendance?.checkOut ?? ""
        }
        
        var createdAt: String {
            attendance?.createdAt ?? ""
        }
    }
}
