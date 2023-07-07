//
//  ScheduleViewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 27/8/22.
//

import Foundation
import SwiftUI

class ScheduleViewModel: ObservableObject{
    @Published var allClasses: [ScheduleModel] = []
    @Published var filteredTasks: [ScheduleModel] = []
    @Published var className: String = ""
    @Published var programmeName: String = ""
    @Published var sectionshiftName: String = ""
    @Published var academicYear: String = ""
    @Published var id: String = ""
    @Published var Error: Bool = false
    @Published var currentWeek: [Date] = []
    // MARK: Current Day
    @Published var currentDay: Date = Date()
    
    init(){
        fetchCurrentWeek()
        filterTodayTasks()
    }
    
    func clearCache(){
        Network.shared.apollo.clearCache()
    }
    
    func resetSchedule(){
        self.allClasses = []
        self.filteredTasks = []
    }
    
    func getClasses(classId: String,academicYearId: String, programId: String){
        Network.shared.apollo.fetch(query: GetSectionShiftByClassIdQuery(classId: classId, academicYearId: academicYearId, programId: programId)){ [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let allClasses = graphQLResult.data?.getSectionShiftByClassId?.sections{
                    self?.allClasses = allClasses.map(ScheduleModel.init)
                }
                if let className = graphQLResult.data?.getSectionShiftByClassId?.classId?.className{
                    self?.className = className
                }
                if let programmeName = graphQLResult.data?.getSectionShiftByClassId?.programId?.programmName{
                    self?.programmeName = programmeName
                }
                if let sectionshiftName = graphQLResult.data?.getSectionShiftByClassId?.sectionShiftName{
                    self?.sectionshiftName = sectionshiftName
                }
                if let id = graphQLResult.data?.getSectionShiftByClassId?._id{
                    self?.id = id
                }
                if let academicYear = graphQLResult.data?.getSectionShiftByClassId?.academicYearId?.academicYear{
                    self?.academicYear = academicYear
                }
                
            case .failure:
                DispatchQueue.main.async {
                    self?.Error = true
                }
            }
        }
    }
    // MARK: Filter Today Tasks
    func filterTodayTasks(){
        DispatchQueue.global(qos: .userInteractive).async {
            let format = "EEEE"
            let formatter = DateFormatter()
            formatter.dateFormat = format
            var Day = formatter.string(from: self.currentDay)
            if Day == "Monday" || Day == "ច័ន្ទ" {
                Day = "Monday"
            } else if Day == "Tuesday" || Day == "អង្គារ"{
                Day = "Tuesday"
            }
            else if Day == "Wednesday" || Day == "ពុធ"{
                Day = "Wednesday"
            }
            else if Day == "Thursday" || Day == "ព្រហស្បតិ៍"{
                Day = "Thursday"
            }
            else if Day == "Friday" || Day == "សុក្រ"{
                Day = "Friday"
            }
            else if Day == "Saturday" || Day == "សៅរ៍"{
                Day = "Saturday"
            }
            else if Day == "Sunday" || Day == "អាទិត្យ"{
                Day = "Sunday"
            } 
            else {
                Day = "Monday"
            }
            
            let filtered = self.allClasses.filter{
                return  $0.dayOfWeek == Day || $0.breakTime == true
            }
                .sorted { task1, task2 in
                    return task1.startTime < task2.startTime
                }
            
            var res:[ScheduleModel] = []
            
            filtered.forEach{ (c) -> () in
                if !res.contains(where: {$0.startTime == c.startTime}){
                    res.append(c)
                }
            }
            DispatchQueue.main.async {
                withAnimation{
                    self.filteredTasks = res
                }
            }
        }
    }
    
    
    func fetchCurrentWeek(){
        
        let today = Date()
        let calendar = NSCalendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        guard let firstWeekDay = week?.start else{
            return 
        }
        (1...7).forEach { day in
            
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
                currentWeek.removeAll(where: {$0 == Date.today().next(.saturday) })
            }
            
        }
    }
    
    // MARK: Extraction Date
    func extractDate(date: Date, format: String)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    // MARK: Checking id current Date is T
    func isToday(date: Date)->Bool{
        let calendar = NSCalendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
}


struct ScheduleModel{
    
    let schedule: GetSectionShiftByClassIdQuery.Data.GetSectionShiftByClassId.Section?
    
    var id: String{
        schedule?._id ?? ""
    }
    var duration: Double{
        schedule?.duration ?? 0
    }
    var startTime: Double{
        schedule?.startTime ?? 0
    }
    var endTime: Double{
        schedule?.endTime ?? 0
    }
    var breakTime: Bool{
        schedule?.breakTime ?? false
    }
    var dayOfWeek: String{
        schedule?.dayOfWeek ?? ""
    }
    var subject: subjectIdModel{
        schedule?.subjectId.map(subjectIdModel.init) ?? subjectIdModel(subject: schedule?.subjectId)
    }
    var leadTeacherId: leadTeacherIdModel{
        schedule?.leadTeacherId.map(leadTeacherIdModel.init) ?? leadTeacherIdModel(leadTeacher: schedule?.leadTeacherId)
    }
    
}

struct subjectIdModel{
    let subject: GetSectionShiftByClassIdQuery.Data.GetSectionShiftByClassId.Section.SubjectId?
    
    var id: String{
        subject?._id ?? ""
    }
    
    var subjectName: String{
        subject?.subjectName ?? ""
    }
}

struct leadTeacherIdModel{
    let leadTeacher: GetSectionShiftByClassIdQuery.Data.GetSectionShiftByClassId.Section.LeadTeacherId?
    
    var id: String{
        leadTeacher?._id ?? ""
    }
    
    var firstName: String{
        leadTeacher?.firstName ?? ""
    }
    
    var lastName: String{
        leadTeacher?.lastName ?? ""
    }
    var englishName: String{
        leadTeacher?.englishName ?? ""
    }
    
    var teacherProfileImg: String {
        leadTeacher?.profileImg ?? ""
    }
}

struct teacherAssistantIdModel {
    let teacherAssistantId: GetSectionShiftByClassIdQuery.Data.GetSectionShiftByClassId.Section.TeacherAssistantId
    
    var id: String{
        teacherAssistantId._id ?? ""
    }
    var firstname: String{
        teacherAssistantId.firstName ?? ""
    }
    var lastname: String{
        teacherAssistantId.lastName ?? ""
    }
}

struct classIdModel {
    let classId: GetSectionShiftByClassIdQuery.Data.GetSectionShiftByClassId.ClassId
    
    var id: String{
        classId._id ?? ""
    }
    var className: String{
        classId.className ??  ""
    }
}

struct programIdModel{
    let programId: GetSectionShiftByClassIdQuery.Data.GetSectionShiftByClassId.ProgramId
    
    var id: String{
        programId._id
    }
    
    var programmeName: String{
        programId.programmName ?? ""
    }
}

struct academicYearIdModel{
    let academicYearId: GetSectionShiftByClassIdQuery.Data.GetSectionShiftByClassId.AcademicYearId
    
    var id: String{
        academicYearId._id ?? ""
    }
    var academicYear: String {
        academicYearId.academicYear ?? ""
    }
}

struct schoolIdModel{
    let schoolId: GetSectionShiftByClassIdQuery.Data.GetSectionShiftByClassId.SchoolId
    
    var id: String{
        schoolId._id
    }
}

extension Date {
    
    static func today() -> Date {
        return Date()
    }
    
    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.next,
                   weekday,
                   considerToday: considerToday)
    }
    
    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.previous,
                   weekday,
                   considerToday: considerToday)
    }
    
    func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             considerToday consider: Bool = false) -> Date {
        
        let dayName = weekDay.rawValue
        
        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1
        
        let calendar = Calendar(identifier: .gregorian)
        
        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
            return self
        }
        
        var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
        nextDateComponent.weekday = searchWeekdayIndex
        
        let date = calendar.nextDate(after: self,
                                     matching: nextDateComponent,
                                     matchingPolicy: .nextTime,
                                     direction: direction.calendarSearchDirection)
        
        return date!
    }
    
}

// MARK: Helper methods
extension Date {
    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    
    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum SearchDirection {
        case next
        case previous
        
        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .next:
                return .forward
            case .previous:
                return .backward
            }
        }
    }
}
