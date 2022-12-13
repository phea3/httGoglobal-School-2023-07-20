//
//  GetTotalStudentViewModel.swift
//  Goglobal School
//
//  Created by Luon Sokphea on 8/12/22.
//

import Foundation
import SwiftUI

class GetTotalStudentViewModel: ObservableObject{
    @Published var allTotal: [GetTotalStudentModel] = []
    
    func getTotal(){
        Network.shared.apollo.fetch(query: GetTotalStudentForAppQuery()){ [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let allTotal = graphQLResult.data?.getTotalStudentForApp {
                    DispatchQueue.main.async {
                        self?.allTotal = allTotal.map(GetTotalStudentModel.init)
//                        print(self?.allTotal as Any)
                    }
                   
                }
            case .failure(_):
                print("")
            }
        }
    }
}

struct GetTotalStudentModel {
    let total: GetTotalStudentForAppQuery.Data.GetTotalStudentForApp?
    
    var StuId: String {
        total?.studentId ?? ""
    }
    
    var GradId: String {
        total?.gradeId ?? ""
    }
    
    var ClassId: String {
        total?.classId ?? ""
    }
    
    var Total: Int {
        total?.total ?? 0
    }
}
