//
//  GetShiftByStudentIdViewModel.swift
//  Goglobal School
//
//  Created by Macmini on 25/4/23.
//

import Foundation

class GetShiftByStudentIdViewModel: ObservableObject {
    @Published var GetAllShift: [GetShiftByStudentModel] = []
    
    func GetShiftNameAndId(studentId: String){
        Network.shared.apollo.fetch(query: GetShiftByStudentIdQuery(stuId: studentId)) { [weak self] result in
            switch result{
                
            case .success(let graphQLResult):
                if let GetAllShift = graphQLResult.data?.getShiftByStudentId{
                    self?.GetAllShift = GetAllShift.map(GetShiftByStudentModel.init)
                }
            case .failure(_):
                print("Error GetShiftByStudentId")
            }
        }
    }
}

struct GetShiftByStudentModel {
    let allshift: GetShiftByStudentIdQuery.Data.GetShiftByStudentId?
    
    var shiftId: String {
        allshift?.shiftId ?? ""
    }
    
    var shiftName: String {
        allshift?.shiftName ?? ""
    }
}
