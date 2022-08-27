//
//  ListScheduleViewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import Foundation
import SwiftUI

class ListScheduleViewModel: ObservableObject{
    
    @Published var Schedules: [ListScheduleModel] = []
    @Published var filteredTasks: [ListScheduleModel] = []
    // MARK: Current Week Days
    @Published var currentWeek: [Date] = []
    // MARK: Current Day
    @Published var currentDay: Date = Date()
    init(){
        fetchCurrentWeek()
    }
    
    func getSchedule(sectionShiftId: String){
        Network.shared.apollo.fetch(query: GetSectionShiftByIdQuery(sectionShiftId: sectionShiftId)){
            [weak self] result in
            
            switch result{
            case .success(let graphQLResult):
                if let Schedules = graphQLResult.data?.getSectionShiftById?.sections{
                    DispatchQueue.main.async {
                        self?.Schedules = Schedules.map(ListScheduleModel.init)
                        print(Schedules)
                    }
                }
            case .failure(let graphQLError):
                print(graphQLError)
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
            if Day == "Monday" || Day == "ចន្ទ" {
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
                Day = "Sunday"
            }
            let filtered = self.Schedules.filter{
                return $0.dayOfWeek == Day
            }
            
            DispatchQueue.main.async {
                withAnimation{
                    self.filteredTasks = filtered
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

struct ListScheduleModel{
    let section: GetSectionShiftByIdQuery.Data.GetSectionShiftById.Section?
    var Code: String {
        (section?._id)!
    }
    var StartTime: Double{
        (section?.startTime)!
    }
    var EndTime: Double{
        (section?.endTime)!
    }
    var dayOfWeek: String{
        (section?.dayOfWeek)!
    }
    var Sbject: String{
        (section?.subjectId?.subjectName)!
    }
    var BreakTime: Bool{
        (section?.breakTime)!
    }
    var Teacher: TeacherModel{
        (section?.leadTeacherId.map(TeacherModel.init))!
    }
}

struct TeacherModel{
    let teacher: GetSectionShiftByIdQuery.Data.GetSectionShiftById.Section.LeadTeacherId
    var Code: String {
        teacher._id
    }
    var Role: String{
        teacher.role!
    }
    var FirstName: String{
        teacher.firstName!
    }
    var LastName: String{
        teacher.lastName!
    }
}
