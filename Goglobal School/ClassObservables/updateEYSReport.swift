//
//  updateEYSReport.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 2/11/22.
//

import Foundation

class updateEYSReportViewModel: ObservableObject {
    @Published var success: Bool = false
    func updateEYSR(){
        Network.shared.apollo.perform(mutation: UpdateEysReportMutation(updateEysReport: EYSReportInputUpdate(_id: "", date: "", stuId: "", parentsCheck: ParentsCheckInput(title: false, description: ""),  parentsComment: ""))) { [weak self] result in 
            switch result{
            case .success(let graphQLResult):
                if let success = graphQLResult.data?.updateEysReport.success {
                    self?.success = success
                }
            case .failure(let graphQLError):
                print(graphQLError.localizedDescription)
            }
        }
    }
}

