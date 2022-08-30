//
//  Schedule.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI

struct Schedule: View {
    @StateObject var AllClasses: ScheduleViewModel = ScheduleViewModel()
    var prop: Properties
    var classId: String
    var academicYearId: String
    var programId: String
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10){
                    ForEach(AllClasses.currentWeek, id: \.self){ day in
                        VStack{
                            DayOfWeek(day: AllClasses.extractDate(date: day, format: "EEE"),dayInKhmer: AllClasses.extractDate(date: day, format: "EEE"))
                            Circle()
                                .fill(.blue)
                                .frame(width: 8, height: 8)
                                .opacity(AllClasses.isToday(date: day) ? 1 : 0)
                        }
                        .onTapGesture {
                            // Updating Current Day
                            withAnimation{
                                AllClasses.currentDay = day
                            }
                        }
                    }
                }
            }
            .padding()
            VStack{
                if let tasks = AllClasses.filteredTasks{
                    if tasks.isEmpty{
                        Text("មិនមានម៉ោងសិក្សា!!!")
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16))
                            .fontWeight(.light)
                            .offset(y:100)
                    } else{
                        List(AllClasses.filteredTasks, id: \.id){ item in
                            customList(startTime: String(format: "%.2f", item.startTime), endTime: String(format: "%.2f", item.endTime), subject: item.subject.subjectName, lastName: item.leadTeacherId.lastName, firstName: item.leadTeacherId.firstName)
                                .backgroundRemover()
                            customListForBreakTime()
                                .backgroundRemover()
                        }
                    }
                }
                else{
                    // MARK: Progress View
                    ProgressView()
                        .offset(y: 100)
                }
            }
            .onChange(of: AllClasses.currentDay) { newValue in
                AllClasses.filterTodayTasks()
            }
            Spacer()
            
        }
        .setBG()
        .onAppear {
            AllClasses.getClasses(classId: classId, academicYearId: academicYearId, programId: programId)
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
            .foregroundColor(Color("bodyBlue"))
            HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                Circle()
                    .font(.system(size: 50))
                    .frame(width: 49, height: 49, alignment: .center)
                    .foregroundColor(Color("bodyBlue"))
                    .overlay(
                        Image(systemName: "graduationcap.circle.fill")
                            .font(.system(size: 50))
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(.white)
                    )
                    .padding(.leading)
                VStack(alignment: .leading){
                    Text(subject)
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                        .listRowBackground(Color.yellow)
                        .foregroundColor(Color("bodyBlue"))
                    HStack{
                        Text(lastName)
                            .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                            .listRowBackground(Color.yellow)
                            .foregroundColor(Color("bodyBlue"))
                        Text(firstName)
                            .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                            .listRowBackground(Color.yellow)
                            .foregroundColor(Color("bodyBlue"))
                    }
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .leading)
            }
            .background(Color("LightBlue"))
            .cornerRadius(15)
        }
        
    }
    func customListForBreakTime()-> some View{
        HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
            VStack(spacing: 0){
                Text("_:_")
                Text("-")
                Text("_:_")
            }
            .font(.custom("Bayon", size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : 18, relativeTo: .callout))
            .foregroundColor(.gray)
            HStack(spacing: 2){
                
                Rectangle()
                    .frame(maxWidth:.infinity, maxHeight: 1)
                    .foregroundColor(.gray)
                Text("ចេញលេង")
                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                    .foregroundColor(.gray)
                Rectangle()
                    .frame(maxWidth:.infinity, maxHeight: 1)
                    .foregroundColor(.gray)
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
        Schedule(prop: prop, classId: "", academicYearId: "", programId: "")
    }
}
