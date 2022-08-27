//
//  Schedule.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI

struct Schedule: View {
    @StateObject var Schedule: ListScheduleViewModel = ListScheduleViewModel()
    var prop: Properties
    var body: some View {
        VStack{
//        if Schedule.Schedules.isEmpty{
//            progressingView(prop: prop)
//        }else{
//
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10){
                        ForEach(Schedule.currentWeek, id: \.self){ day in
                            VStack{
                                DayOfWeek(day: Schedule.extractDate(date: day, format: "EEE"),dayInKhmer: Schedule.extractDate(date: day, format: "EEE"))
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 8, height: 8)
                                    .opacity(Schedule.isToday(date: day) ? 1 : 0)
                            }
                            .onTapGesture {
                                // Updating Current Day
                                withAnimation{
                                    Schedule.currentDay = day
                                }
                            }
                        }
                    }
                }
                .padding()
                VStack{
                    if let tasks = Schedule.filteredTasks{
                        if tasks.isEmpty{
                            Text("មិនមានម៉ោងសិក្សា!!!")
                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16))
                                .fontWeight(.light)
                                .offset(y:100)
                        } else{
                            List(Schedule.filteredTasks, id: \.Code){ item in
                                customList(startTime: String(format: "%.2f", item.StartTime), endTime: String(format: "%.2f", item.EndTime), subject: item.Sbject, lastName: item.Teacher.LastName, firstName: item.Teacher.FirstName)
                            }
                        }
                    }
                    else{
                        // MARK: Progress View
                        ProgressView()
                            .offset(y: 100)
                    }
                }
                .onChange(of: Schedule.currentDay) { newValue in
                    Schedule.filterTodayTasks()
                }
                Spacer()
//            }
           
        }
        .setBG()
        .onAppear {
            Schedule.getSchedule(sectionShiftId: "")
        }
    }
    
    func DayOfWeek(day: String, dayInKhmer: String)->some View {
        ZStack{
            Circle()
                .fill(.white)
                .frame(width: 40, height: 40)
            Text(dayInKhmer)
                .foregroundColor(Color(day))
                .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
        }
        .frame(width: 55, height: 55)
        .background(Color(day))
        .cornerRadius(5)
    }
    func customList(startTime: String, endTime: String, subject: String, lastName: String, firstName: String)-> some View{
        HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
            VStack(spacing: 0){
                Text(startTime)
                    .font(.system(size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20))
                Text("-")
                Text(endTime)
                    .font(.system(size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20))
            }
            .font(.custom("Bayon", size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : 18, relativeTo: .callout))
            .foregroundColor(Color("Body1"))
            HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                Circle()
                    .font(.system(size: 50))
                    .frame(width: 49, height: 49, alignment: .center)
                    .foregroundColor(Color("DarkBlue"))
                    .overlay(
                        Image(systemName: "graduationcap.circle.fill")
                            .font(.system(size: 50))
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(.white)
                    )
                VStack(alignment: .leading){
                    Text(subject)
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                        .listRowBackground(Color.yellow)
                        .foregroundColor(Color("DarkBlue"))
                    HStack{
                        Text(lastName)
                            .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                            .listRowBackground(Color.yellow)
                            .foregroundColor(Color("DarkBlue"))
                        Text(firstName)
                            .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                            .listRowBackground(Color.yellow)
                            .foregroundColor(Color("DarkBlue"))
                    }
                }
            }
            .background(Color("Blue"))
            .cornerRadius(15)
        }
        .backgroundRemover()
    }
    func customListForBreakTime()-> some View{
        HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
            VStack(spacing: 0){
                Text("០៨:០០")
                Text("-")
                Text("០៨:៤៥")
            }
            .font(.custom("Bayon", size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : 18, relativeTo: .callout))
            .foregroundColor(Color("Sun"))
            HStack(spacing: 2){
                
                Rectangle()
                    .frame(maxWidth:.infinity, maxHeight: 1)
                    .foregroundColor(.red)
                Text("ចេញលេង")
                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                    .foregroundColor(.red)
                Rectangle()
                    .frame(maxWidth:.infinity, maxHeight: 1)
                    .foregroundColor(.red)
            }
            .padding()
            .background(Color.clear)
            .cornerRadius(10)
        }
        .backgroundRemover()
    }
}

struct Schedule_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Schedule(prop: prop)
    }
}
