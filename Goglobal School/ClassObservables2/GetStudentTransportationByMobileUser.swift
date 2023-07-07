//
//  GetStudentTransportationByMobileUser.swift
//  Goglobal School
//
//  Created by loun sokphea on 4/7/23.
//

import Foundation

class GetStudentTransportationByMobileUser: ObservableObject {
    @Published var students: [GetStudentTransportationByMobileUserModel] = []
    @Published var Error: Bool = false
    
    func getStudent(parentId: String) {
        Network2.shared.apollo.fetch(query: GetStudentTransportationByMobileUserQuery(id: parentId)){ [weak self] result in
            switch result{
            case .success(let graqhqlresult):
                if let students = graqhqlresult.data?.getStudentTransportationByMobileUser {
                    DispatchQueue.main.async {
                        self?.students = students.map(GetStudentTransportationByMobileUserModel.init)
                        //                        print(self?.students as Any)
                    }
                }
            case .failure(_):
                print("GetStudentTransportationByMobileUser ERROR")
                DispatchQueue.main.async {
                    self?.Error = true
                }
            }
        }
    }
    
    func clearCache(){
        Network2.shared.apollo.clearCache()
    }
    
    func resetStudent(){
        DispatchQueue.main.async {
            self.students = []
        }
    }
    
    struct GetStudentTransportationByMobileUserModel {
        let student: GetStudentTransportationByMobileUserQuery.Data.GetStudentTransportationByMobileUser?
        
        var id: String {
            student?._id ?? ""
        }
        
        var firstname: String {
            student?.firstName ?? ""
        }
        
        var lastname: String {
            student?.lastName ?? ""
        }
        
        var englishname: String {
            student?.englishName ?? ""
        }
        
        var profileimage: String {
            student?.profileImg ?? ""
        }
    }
}
