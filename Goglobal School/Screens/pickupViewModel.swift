//
//  pickupViewModel.swift
//  Goglobal School
//
//  Created by Luon Sokphea on 19/12/22.
//

import Foundation

class PickupViewModel: ObservableObject {
    
    @Published var success: Bool = false
    @Published var message: String = ""
    
    func pickup(stuId: String, picked: Bool){
        Network.shared.apollo.perform(mutation: CreatePickingUpMutation(newPickingUp: PickingUpInput(studentId: stuId, picked: picked))) { [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let success = graphQLResult.data?.createPickingUp?.success {
                    DispatchQueue.main.async {
                        self?.success = success
                    }
                }
                if let message = graphQLResult.data?.createPickingUp?.message {
                    DispatchQueue.main.async {
                        self?.message = message
                    }
                }
            case .failure:
                print("")
            }
        }
    }
}
