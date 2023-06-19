//
//  GetTransportationViewModel.swift
//  Goglobal School
//
//  Created by loun sokphea on 19/6/23.
//

import Foundation

class GetTransportationViewModel: ObservableObject{
    @Published var userTrans: [GetTransportationModel] = []
    func getUserTrans(){
        Network.shared.apollo.fetch(query: GetTransportationQuery()){ [weak self] result in
            switch result {
            case .success(let graphQLResult):
                if let userTrans = graphQLResult.data?.getTransportation{
                    self?.userTrans = userTrans.map(GetTransportationModel.init)
                }
            case .failure(_):
                print("Error GetTransportationViewModel")
            }
        }
    }
}

struct GetTransportationModel{
    let users: GetTransportationQuery.Data.GetTransportation
    
    var id: String {
        users._id
    }
    
    var parentId: String {
        users.parentId?._id ?? ""
    }
}
