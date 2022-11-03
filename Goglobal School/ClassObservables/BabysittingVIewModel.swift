//
//  BabysittingVIewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 24/10/22.
//

import Foundation
import SwiftUI

class BadysittingViewModel: ObservableObject{
    
    // MARK: Current Week Days
    
    @Published var currentWeek: [Date] = []
    
    // MARK: Current Day
    
    @Published var currentDay: Date = Date()
    
    // MARK: Data
    
    @Published var allReports: [BadysittingModel] = []
    
    @Published var filteredTasks: [BadysittingModel]?
    
    func getAllReports(stuId: String){
        
        Network.shared.apollo.fetch(query: GetEysReportPaginationQuery(stuId: stuId, date: nil)){ [weak self] result in
            
            switch result{
            case .success(let graphQLResult):
                if let allReports = graphQLResult.data?.getEysReportPagination.data {
                    self?.allReports = allReports.map(BadysittingModel.init)
                }
            case .failure(let grahphQLError):
                print(grahphQLError.localizedDescription)
            }
            
        }
    }
    
    init(){
        fetchCurrentWeek()
        filterTodayTasks()
    }
    func filterTodayTasks() {
        DispatchQueue.global(qos: .userInteractive).async { [self] in
            let calendar = Calendar.current
            let filtered = self.allReports.filter {
                return calendar.isDate(convertDate(inputDate: $0.Date), inSameDayAs: self.currentDay)
            }
                .sorted { task1, task2 in
                    return task2.Date > task1.Date
                }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    private func convertDate(inputDate: String) -> Date{
        let isoDate = inputDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:isoDate)!
        return date
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

struct BadysittingModel {
    
    let allReports: GetEysReportPaginationQuery.Data.GetEysReportPagination.Datum
    
    var Id: String {
        allReports._id ?? ""
    }
    
    var Date: String {
        allReports.date ?? ""
    }
    
    var Food: [FoodReportModel] {
        (allReports.food?.map(FoodReportModel.init)) ?? []
    }
    
    var Activity: [ActivityReportModel] {
        (allReports.activities?.map(ActivityReportModel.init)) ?? []
    }
    
    var ParentsRequest: [String?] {
        allReports.parentsRequest ?? []
    }
}

struct FoodReportModel {
    
    let allFoodReport: GetEysReportPaginationQuery.Data.GetEysReportPagination.Datum.Food?
    
    var IconSrc: String {
        allFoodReport?.iconsrc ?? ""
    }
    
    var IconName: String {
        allFoodReport?.iconname ?? ""
    }
    
    var Title: String {
        allFoodReport?.title ?? ""
    }
    
    var Qty: Int {
        allFoodReport?.qty ?? 0
    }
    
    var Description: String {
        allFoodReport?.description ?? ""
    }
}

struct ActivityReportModel {
    
    let allActivityReport: GetEysReportPaginationQuery.Data.GetEysReportPagination.Datum.Activity?
    
    var IconSrc: String {
        allActivityReport?.iconsrc ?? ""
    }
    
    var IconName: String {
        allActivityReport?.iconname ?? ""
    }
    
    var Title: String {
        allActivityReport?.title ?? ""
    }
    
    var Qty: Int {
        allActivityReport?.qty ?? 0
    }
    
    var Description: String {
        allActivityReport?.description ?? ""
    }
    
}
