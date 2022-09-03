//
//  ListStudentViewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//
import Foundation

class ListStudentViewModel: ObservableObject {
    
    @Published var AllStudents: [StudentsViewModel] = []
    @Published var Error: Error?
    
    func StundentAmount(parentId: String){
        Network.shared.apollo.fetch(query: GetStudentsByParentsQuery(parentId: parentId)) { [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let AllStudents = graphQLResult.data?.getStudentsByParents{
                    DispatchQueue.main.async {
                        self?.AllStudents = AllStudents.map(StudentsViewModel.init)
                    }
                }
            case.failure(let graphError):
                DispatchQueue.main.async {
                    self?.Error = graphError
                }
            }
        }
    }
}

struct StudentsViewModel {
    
    let student: GetStudentsByParentsQuery.Data.GetStudentsByParent?
    var Id: String {
        student?._id ?? ""
    }
    var Firstname: String{
        student?.firstName ?? ""
    }
    var Lastname: String{
        student?.lastName ?? ""
    }
    var profileImage: String {
        student?.profileImg  ?? ""
    }
    var Enrollments: [EnrollmentsViewModel] {
        (student?.enrollments?.map(EnrollmentsViewModel.init))!
    }
}

struct EnrollmentsViewModel {
    
    let enrollment: GetStudentsByParentsQuery.Data.GetStudentsByParent.Enrollment?
    var id: String {
        enrollment?._id ?? ""
    }
    var ClassName: String {
        enrollment?.className ?? ""
    }
    var StartDate: String {
        enrollment?.startDate ?? ""
    }
    var EndDate: String {
        enrollment?.endDate ?? ""
    }
    var ProgramId: programViewModel{
        (enrollment?.programId.map(programViewModel.init))!
    }
    var AcademicYearId: academicYearViewModel {
        (enrollment?.academicYearId.map(academicYearViewModel.init))!
    }
    var GradeId: gradeViewModel {
        ( enrollment?.gradeId.map(gradeViewModel.init))!
    }
    var classId: ClassIdModel{
        (enrollment?.classId.map(ClassIdModel.init))!
    }
}

struct programViewModel {
    let program: GetStudentsByParentsQuery.Data.GetStudentsByParent.Enrollment.ProgramId
    var Id: String {
        program._id
    }
    var ProgramName: String {
        program.programmName ?? ""
    }
}

struct academicYearViewModel {
    let academicYear: GetStudentsByParentsQuery.Data.GetStudentsByParent.Enrollment.AcademicYearId
    var Id: String {
        academicYear._id ?? ""
    }
    var AcademicYear: String {
        academicYear.academicYear ?? ""
    }
}

struct gradeViewModel {
    let gradeId: GetStudentsByParentsQuery.Data.GetStudentsByParent.Enrollment.GradeId
    
    var Id: String {
        gradeId._id ?? ""
    }
    var GradeName: String {
        gradeId.gradeName ?? ""
    }
}

struct ClassIdModel {
    let classId: GetStudentsByParentsQuery.Data.GetStudentsByParent.Enrollment.ClassId
    
    var Id: String {
        classId._id ?? ""
    }
    var ClassName: String {
        classId.className ?? ""
    }
}
