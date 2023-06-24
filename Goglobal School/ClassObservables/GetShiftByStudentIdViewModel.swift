//
//  GetShiftByStudentIdViewModel.swift
//  Goglobal School
//
//  Created by Macmini on 25/4/23.
//

import Foundation

class GetShiftByStudentIdViewModel: ObservableObject {
    @Published var GetAllShift1: [GetShiftByStudentModel] = []
    @Published var GetAllShift: [NewShift] = []
    @Published var newshift = [
        NewShift(shiftId: "",shiftName: "ជ្រើសរើស"),
        NewShift(shiftId: "null", shiftName: "All day")
    ]
    func GetShiftNameAndId(studentId: String){
        Network.shared.apollo.fetch(query: GetShiftByStudentIdQuery(stuId: studentId)) { [weak self] result in
            switch result{
                
            case .success(let graphQLResult):
                if let GetAllShift = graphQLResult.data?.getShiftByStudentId{
                    self?.GetAllShift1 = GetAllShift.map(GetShiftByStudentModel.init)
                    self?.GetAllShift = (self?.newshift ?? []) + (self?.GetAllShift1.map{
                        NewShift(shiftId: $0.shiftId, shiftName: $0.shiftName)
                    } ?? [])
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

struct NewShift {
    
    var shiftId: String
    var shiftName: String
    
    init(shiftId: String, shiftName: String) {
        self.shiftId = shiftId
        self.shiftName = shiftName
    }
}
