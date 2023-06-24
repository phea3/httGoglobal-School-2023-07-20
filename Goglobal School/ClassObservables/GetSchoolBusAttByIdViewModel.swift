//
//  GetSchoolBusAttByIdViewModel.swift
//  Goglobal School
//
//  Created by loun sokphea on 19/6/23.
//

import Foundation
import Apollo

class GetSchoolBusAttByIdViewModel: ObservableObject {
    @Published var schoolBus: [GetSchoolBusAttByIdModel] = []
    @Published var GraphQLError: String = ""
    
    func getSchoolBus(stuId: String, limit: Int){
        Network.shared.apollo.fetch(query: GetSchoolBusAttByIdQuery(stuId: stuId, limit: limit)){ [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let GraphQLError = graphQLResult.errors{
                    DispatchQueue.main.async {
//                        print("\( GraphQLError.map({"\($0)"}).joined(separator:"-") )")
                        self?.GraphQLError = GraphQLError.map{"\($0.message ?? "")"}.joined()
                    }
                }
                if let schoolBus = graphQLResult.data?.getSchoolBusAttById{
                    DispatchQueue.main.async {
                        self?.schoolBus = schoolBus.map(GetSchoolBusAttByIdModel.init)
                    }
                }
            case .failure(let grahpQLError):
                print(grahpQLError.localizedDescription)
            }
        }
    }
    
    struct GraphQLError {
        let Error : GetSchoolBusAttByIdQuery
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

