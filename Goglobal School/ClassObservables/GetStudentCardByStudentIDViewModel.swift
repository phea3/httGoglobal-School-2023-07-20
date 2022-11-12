//
//  GetStudentCardByStudentIDViewModel.swift
//  Goglobal School
//
//  Created by Luon Sokphea on 10/11/22.
//

import Foundation

class GetStudentCardByStudentIDViewModel: ObservableObject{
    @Published var Status: Bool = false
    @Published var studentId: String = ""
    func getQRCode(stuID: String) {
        Network.shared.apollo.fetch(query: GetStudentCardByStudentIdQuery(studentId: stuID)) { [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let Status = graphQLResult.data?.getStudentCardByStudentId?.status {
                    self?.Status = Status
                }
                if let studentId = graphQLResult.data?.getStudentCardByStudentId?._id {
                    self?.studentId = studentId
                }
            case .failure(_):
                print("")
            }
        }
    }
}
