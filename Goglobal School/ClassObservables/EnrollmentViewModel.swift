//
//  EnrollmentViewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 22/9/22.
//

import Foundation
class EnrollmentViewModel: ObservableObject{
    @Published var enrollments: [EnrollmentModel] = []
    
    func getEnrollment(studentId: String){
        Network.shared.apollo.fetch(query: GetEnrollmentByStudentsQuery(studentId: studentId)){ [weak self] result in
            switch result{
                
            case .success(let graphQLResult):
                if let enrollments = graphQLResult.data?.getEnrollmentByStudents {
                    self?.enrollments = enrollments.map(EnrollmentModel.init)
                }
            case .failure(let graphQLError):
                print(graphQLError)
            }
        }
    }
}
struct EnrollmentModel{
    var enrollment : GetEnrollmentByStudentsQuery.Data.GetEnrollmentByStudent?
    
    var Firstname: String{
        enrollment?.firstName ?? ""
    }
    var Lastname: String{
        enrollment?.lastName ?? ""
    }
    var EnglishName: String{
        enrollment?.englishName ?? ""
    }
    var Programme: String{
        enrollment?.programName ?? ""
    }
    var GradeName: String{
        enrollment?.gradeName ?? ""
    }
    var Shiftname: String{
        enrollment?.shiftName ?? ""
    }
    var Classname: String{
        enrollment?.className ?? ""
    }
    var AcademicYearName: String{
        enrollment?.academicYearName ?? ""
    }
    var State: Bool {
        enrollment?.status ?? false
    }
    var EnrollmentId: String {
        enrollment?.enrollmentId ?? ""
    }
    var ProgrammeId: String{
        enrollment?.programId ?? ""
    }
    var GradeId: String{
        enrollment?.gradeId ?? ""
    }
    var ShiftId: String{
        enrollment?.gradeId ?? ""
    }
    var ClassId: String {
        enrollment?.classId ?? ""
    }
    var AcademicId: String {
        enrollment?.academicYearId ?? ""
    }
    
    var ClassGroupId: String {
        enrollment?.classGroupId ?? ""
    }
    
    var ClassGroupNameEn: String {
        enrollment?.classGroupNameEn ?? ""
    }
    
    var classGroupName: String {
        enrollment?.classGroupName ?? ""
    }
    
    var studentId: String {
        enrollment?.studentId ?? ""
    }
}
