//
//  GetSchoolBusAttByIdViewModel.swift
//  Goglobal School
//
//  Created by loun sokphea on 19/6/23.
//

import Foundation

class GetSchoolBusAttByIdViewModel: ObservableObject {
    @Published var schoolBus: [GetSchoolBusAttByIdModel] = []
    
    func getSchoolBus(stuId: String, limit: Int){
        Network.shared.apollo.fetch(query: GetSchoolBusAttByIdQuery(stuId: stuId, limit: limit)){ [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let schoolBus = graphQLResult.data?.getSchoolBusAttById{
                    self?.schoolBus = schoolBus.map(GetSchoolBusAttByIdModel.init)
                }
            case .failure(_):
                print("")
            }
        }
    }
    struct GetSchoolBusAttByIdModel {
        let schoolBus: GetSchoolBusAttByIdQuery.Data.GetSchoolBusAttById?
        
        var studentId: String {
            schoolBus?.studentId ?? ""
        }
        
        var attendanceDate: String {
            schoolBus?.attendanceDate ?? ""
        }
        
        var pickUpAt: String {
            schoolBus?.pickUpAt ?? ""
        }
        
        var sendOffAt: String {
            schoolBus?.sendOffAt ?? ""
        }
    }
}
