//
//  updateEYSReport.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 2/11/22.
//

import Foundation

class updateEYSReportViewModel: ObservableObject {
    @Published var success: Bool = false
    @Published var message: String = ""
    
    func updateEYSR(id: String, date: String, stuId: String,title: Bool, description: String,parentsComment:String){
        Network.shared.apollo.perform(mutation: UpdateEysReportMutation(updateEysReport: EYSReportInputUpdate(_id: id, date: date, stuId: stuId, parentsCheck: ParentsCheckInput(title: title, description: description),  parentsComment: parentsComment))) { [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let success = graphQLResult.data?.updateEysReport.success {
                    self?.success = success
                }
                if let message = graphQLResult.data?.updateEysReport.message {
                    self?.message = message
                }
            case .failure(let graphQLError):
                print(graphQLError.localizedDescription)
            }
        }
    }
    
    func clearCache(){
        Network.shared.apollo.clearCache()
    }
    
    func reset(){
        DispatchQueue.main.async {
            self.success = false
        }
    }
}

