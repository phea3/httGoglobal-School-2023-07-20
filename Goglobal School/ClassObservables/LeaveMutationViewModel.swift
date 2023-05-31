//
//  LeaveMutationViewModel.swift
//  Goglobal School
//
//  Created by Macmini on 25/4/23.
//

import Foundation

class LeaveMutationViewModel: ObservableObject {
    @Published var startDate: String = ""
    @Published var endDate: String = ""
    @Published var reason: String = ""
    @Published var requestDate: String = ""
    @Published var shiftName: String = ""
    @Published var success: Bool = false
    @Published var message: String = ""
    
    func creatLeaveRequest(startDate: String, endDate: String, reason: String, parentId: String, studentId: String, shiftId: String){
        Network.shared.apollo.perform(mutation: CreatePermissionMutation(newData: PermissionInput(parentId: parentId, studentId: studentId, shiftId: shiftId, startDate: startDate, endDate: endDate, reason: reason))) { [weak self] result in
            switch result{
                
            case .success(let graphqlResult):
                if let startDate = graphqlResult.data?.createPermission?.startDate {
                    DispatchQueue.main.async {
                        self?.startDate = startDate
                    }
                }
                if let endDate = graphqlResult.data?.createPermission?.endDate {
                    DispatchQueue.main.async {
                        self?.endDate = endDate
                    }
                }
                if let reason = graphqlResult.data?.createPermission?.reason {
                    DispatchQueue.main.async {
                        self?.reason = reason
                    }
                }
                if let requestDate = graphqlResult.data?.createPermission?.requestDate {
                    DispatchQueue.main.async {
                        self?.requestDate = requestDate
                    }
                }
                if let shiftName = graphqlResult.data?.createPermission?.shiftName {
                    DispatchQueue.main.async {
                        self?.shiftName = shiftName
                    }
                }
                if let success = graphqlResult.data?.createPermission?.success {
                    DispatchQueue.main.async {
                        self?.success = success
                    }
                }
                if let message = graphqlResult.data?.createPermission?.message {
                    DispatchQueue.main.async {
                        self?.message = message
                    }
                }
            case .failure(_):
                print("error leavemutation")
            }
        }
    }
}


