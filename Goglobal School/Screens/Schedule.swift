//
//  Schedule.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI

struct Schedule: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var AllClasses: ScheduleViewModel = ScheduleViewModel()
    @State var loadingScreen: Bool = false
    @State var currentProgress: CGFloat = 0
    @State var loadingImg: Bool = false
    @Binding var showTeacherImage: Bool
    @Binding var UrlImg: String
    var prop: Properties
    var classId: String
    var academicYearId: String
    var programId: String
    var language: String
    //    let foo: String = "optional string"
    var body: some View {
        
        VStack(spacing:0){
            HStack(spacing: prop.isiPad ? 20 : prop.isiPhone && prop.isLandscape ? 20 : 10){
                ForEach(AllClasses.currentWeek, id: \.self){ day in
                    if (AllClasses.extractDate(date: day, format: "EEE") != "Sun") && (AllClasses.extractDate(date: day, format: "EEE") != "អាទិត្យ") {
                        VStack{
                            DayOfWeek(day: AllClasses.extractDate(date: day, format: "EEE"), dayInKhmer: AllClasses.extractDate(date: day, format: "EEE"))
                            Rectangle()
                                .fill(.blue)
                                .frame(width: prop.isiPad ? 55 : prop.isiPhoneS ?  40 : prop.isiPhoneM ? 45 : 55, height: prop.isiPad ? 6 :  4)
                            //                                .cornerRadius(10)
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
            .padding(.top)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .center)
            
            if loadingScreen{
                ProgressView(value: currentProgress, total: 1000)
                    .padding(.top)
                Spacer()
                    .onAppear{
                        self.currentProgress = 250
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                            self.currentProgress = 500
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            self.currentProgress = 750
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                            self.currentProgress = 1000
                        }
                    }
                
            }else{
                VStack{
                    if AllClasses.filteredTasks.isEmpty{
                        Text("មិនមានម៉ោងសិក្សា!!!".localizedLanguage(language: self.language))
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16))
                            .fontWeight(.light)
                            .offset(y: prop.isLandscape ? 100 :  300)
                    } else{
                        List(Array(AllClasses.filteredTasks.enumerated()), id: \.element.id){ index, item in
                            customList(startTime: String(format: "%.2f", item.startTime), endTime: String(format: "%.2f", item.endTime), subject: item.subject.subjectName, lastName: item.leadTeacherId.lastName, firstName: item.leadTeacherId.firstName, breaktime: item.breakTime, index: index, profileImg: item.leadTeacherId.teacherProfileImg)
                                .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                .backgroundRemover()
                                .padding(.vertical , prop.isiPad ? 5: 0 )
                        }
                        .padding(.bottom, prop.isiPhoneS && !prop.isLandscape ? 20 : prop.isiPhoneM && !prop.isLandscape ? 30 : prop.isiPhoneL && !prop.isLandscape ? 40 : prop.isiPad ? 60 : 0)
                    }
                }
                .onAppear{
                    AllClasses.filterTodayTasks()
                }
                .onChange(of: AllClasses.currentDay) { newValue in
                    AllClasses.filterTodayTasks()
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .setBG(colorScheme: colorScheme)
        .onAppear {
            AllClasses.getClasses(classId: classId, academicYearId: academicYearId, programId: programId)
            self.loadingScreen = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.loadingScreen = false
            }
        }
    }
    
    func DayOfWeek(day: String, dayInKhmer: String)-> some View {
        ZStack{
            Circle()
                .fill(.white)
                .frame(width: prop.isiPad ? 40 : prop.isiPhoneS ?  30 : prop.isiPhoneM ? 35  : 40, height: prop.isiPad ? 40 : prop.isiPhoneS ?  30 : prop.isiPhoneM ? 35 : 40)
            Text(dayInKhmer)
                .foregroundColor(Color(day))
                .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 20, relativeTo: .body))
        }
        .frame(width: prop.isiPad ? 55 : prop.isiPhoneS ?  40 : prop.isiPhoneM ? 45 : 55, height: prop.isiPad ? 55 : prop.isiPhoneS ?  40 : prop.isiPhoneM ? 45 : 55)
        .background(Color(day))
        .cornerRadius( prop.isiPad ? 10 : 5)
    }
    func customList(startTime: String, endTime: String, subject: String, lastName: String, firstName: String, breaktime: Bool, index: Int, profileImg: String)-> some View{
        HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
            VStack(alignment: .leading, spacing: 0){
                Text(language == "en" ? startTime : convertStartTime(startTime: startTime))
                    .font(.system(size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20))
                    .offset(y: 8)
                Text("-")
                    .padding(.leading, 5)
                Text(language == "en" ? endTime :convertEndTime(endTime: endTime))
                    .font(.system(size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20))
                    .offset(y: -8)
            }
            .font(.custom("Bayon", size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : 18, relativeTo: .callout))
            .foregroundColor(Color(breaktime ? "redding" : index % 2 == 0 ?  "bodyOrange" : "bodyBlue"))
            .frame(width: prop.isiPhoneS ? 54 : prop.isiPhoneM ? 56 : prop.isiPhoneL ? 58 : 60)
            if breaktime{
                HStack(spacing: prop.isiPhoneS ? 2 : prop.isiPhoneM ? 3 : 4){
                    
                    Rectangle()
                        .frame(maxHeight: 1)
                        .foregroundColor(Color("redding"))
                    Text("ម៉ោងចេញលេង".localizedLanguage(language: self.language))
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                        .foregroundColor(Color("redding"))
                        .frame(width: 90)
                    Rectangle()
                        .frame(maxHeight: 1)
                        .foregroundColor(Color("redding"))
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .leading)
            }else{
                HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                    Circle()
                        .font(.system(size: 50))
                        .frame(width: 49, height: 49, alignment: .center)
                        .foregroundColor(Color(index % 4 == 0 ?"LightOrange":"LightBlue"))
                        .overlay(
                            ZStack{
                                AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(profileImg)"), content: { image in
                                    switch image{
                                    case .empty:
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: Color(index % 4 == 0 ?"bodyOrange":"bodyBlue")))
                                            .frame(width: 50, height: 50)
                                    case .success(let image):
                                        Button {
                                            DispatchQueue.main.asyncAfter(deadline:.now() + 0.2){
                                                self.showTeacherImage = true
                                            }
                                            self.UrlImg = "https://storage.go-globalschool.com/api\(profileImg)"
                                        } label: {
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .clipShape(Circle())
                                                .frame(width: 50, height: 50)
                                        }
                                    case .failure:
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color(index % 4 == 0 ?"bodyOrange":"bodyBlue"))
                                            .background(
                                                Circle()
                                                    .fill(.white)
                                                    .frame(width: 45 , height: 45)
                                            )
                                    @unknown default:
                                        // Since the AsyncImagePhase enum isn't frozen,
                                        // we need to add this currently unused fallback
                                        // to handle any new cases that might be added
                                        // in the future:
                                        EmptyView()
                                    }
                                })
                                //                                }
                            }
                            
                        )
                        .padding(.leading)
                    VStack(alignment: .leading){
                        Text(subject)
                            .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                            .listRowBackground(Color.yellow)
                            .foregroundColor(Color(index % 4 == 0 ?"bodyOrange":"bodyBlue"))
                        HStack{
                            Text(lastName)
                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                                .listRowBackground(Color.yellow)
                                .foregroundColor(Color(index % 4 == 0 ?"bodyOrange":"bodyBlue"))
                            Text(firstName)
                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                                .listRowBackground(Color.yellow)
                                .foregroundColor(Color(index % 4 == 0 ?"bodyOrange":"bodyBlue"))
                        }
                    }
                    .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .leading)
                }
                .background(Color(colorScheme == .dark ? "Black" : index % 4 == 0 ? "LightOrange" : "LightBlue"))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.orange, lineWidth: colorScheme == .dark ? 1 : 0)
                )
            }
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .leading)
    }
}

struct Schedule_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Schedule(showTeacherImage: .constant(false), UrlImg: .constant(""), prop: prop, classId: "", academicYearId: "", programId: "", language: "em")
    }
}

private func convertStartTime(startTime: String)-> String{
    
    let newTime = startTime
        .replacingOccurrences(of: "0", with: "០", options: .literal, range: nil)
        .replacingOccurrences(of: "1", with: "១", options: .literal, range: nil)
        .replacingOccurrences(of: "2", with: "២", options: .literal, range: nil)
        .replacingOccurrences(of: "3", with: "៣", options: .literal, range: nil)
        .replacingOccurrences(of: "4", with: "៤", options: .literal, range: nil)
        .replacingOccurrences(of: "5", with: "៥", options: .literal, range: nil)
        .replacingOccurrences(of: "6", with: "៦", options: .literal, range: nil)
        .replacingOccurrences(of: "7", with: "៧", options: .literal, range: nil)
        .replacingOccurrences(of: "8", with: "៨", options: .literal, range: nil)
        .replacingOccurrences(of: "9", with: "៩", options: .literal, range: nil)
        .replacingOccurrences(of: "10", with: "១០", options: .literal, range: nil)
        .replacingOccurrences(of: "11", with: "១១", options: .literal, range: nil)
        .replacingOccurrences(of: "12", with: "១២", options: .literal, range: nil)
        .replacingOccurrences(of: "13", with: "១៣", options: .literal, range: nil)
        .replacingOccurrences(of: "14", with: "១៤", options: .literal, range: nil)
        .replacingOccurrences(of: "15", with: "១៥", options: .literal, range: nil)
        .replacingOccurrences(of: "16", with: "១៦", options: .literal, range: nil)
        .replacingOccurrences(of: "17", with: "១៧", options: .literal, range: nil)
        .replacingOccurrences(of: "18", with: "១៨", options: .literal, range: nil)
        .replacingOccurrences(of: "19", with: "១៩", options: .literal, range: nil)
        .replacingOccurrences(of: "20", with: "២០", options: .literal, range: nil)
        .replacingOccurrences(of: "21", with: "២១", options: .literal, range: nil)
        .replacingOccurrences(of: "22", with: "២២", options: .literal, range: nil)
        .replacingOccurrences(of: "23", with: "២៣", options: .literal, range: nil)
        .replacingOccurrences(of: "24", with: "២៤", options: .literal, range: nil)
        .replacingOccurrences(of: "25", with: "២៥", options: .literal, range: nil)
        .replacingOccurrences(of: "26", with: "២៦", options: .literal, range: nil)
        .replacingOccurrences(of: "27", with: "២៧", options: .literal, range: nil)
        .replacingOccurrences(of: "28", with: "២៨", options: .literal, range: nil)
        .replacingOccurrences(of: "29", with: "២៩", options: .literal, range: nil)
        .replacingOccurrences(of: "30", with: "៣០", options: .literal, range: nil)
        .replacingOccurrences(of: "31", with: "៣១", options: .literal, range: nil)
    
    return newTime
}

private func convertEndTime(endTime: String)-> String{
    
    let newTime = endTime
        .replacingOccurrences(of: "0", with: "០", options: .literal, range: nil)
        .replacingOccurrences(of: "1", with: "១", options: .literal, range: nil)
        .replacingOccurrences(of: "2", with: "២", options: .literal, range: nil)
        .replacingOccurrences(of: "3", with: "៣", options: .literal, range: nil)
        .replacingOccurrences(of: "4", with: "៤", options: .literal, range: nil)
        .replacingOccurrences(of: "5", with: "៥", options: .literal, range: nil)
        .replacingOccurrences(of: "6", with: "៦", options: .literal, range: nil)
        .replacingOccurrences(of: "7", with: "៧", options: .literal, range: nil)
        .replacingOccurrences(of: "8", with: "៨", options: .literal, range: nil)
        .replacingOccurrences(of: "9", with: "៩", options: .literal, range: nil)
        .replacingOccurrences(of: "10", with: "១០", options: .literal, range: nil)
        .replacingOccurrences(of: "11", with: "១១", options: .literal, range: nil)
        .replacingOccurrences(of: "12", with: "១២", options: .literal, range: nil)
        .replacingOccurrences(of: "13", with: "១៣", options: .literal, range: nil)
        .replacingOccurrences(of: "14", with: "១៤", options: .literal, range: nil)
        .replacingOccurrences(of: "15", with: "១៥", options: .literal, range: nil)
        .replacingOccurrences(of: "16", with: "១៦", options: .literal, range: nil)
        .replacingOccurrences(of: "17", with: "១៧", options: .literal, range: nil)
        .replacingOccurrences(of: "18", with: "១៨", options: .literal, range: nil)
        .replacingOccurrences(of: "19", with: "១៩", options: .literal, range: nil)
        .replacingOccurrences(of: "20", with: "២០", options: .literal, range: nil)
        .replacingOccurrences(of: "21", with: "២១", options: .literal, range: nil)
        .replacingOccurrences(of: "22", with: "២២", options: .literal, range: nil)
        .replacingOccurrences(of: "23", with: "២៣", options: .literal, range: nil)
        .replacingOccurrences(of: "24", with: "២៤", options: .literal, range: nil)
        .replacingOccurrences(of: "25", with: "២៥", options: .literal, range: nil)
        .replacingOccurrences(of: "26", with: "២៦", options: .literal, range: nil)
        .replacingOccurrences(of: "27", with: "២៧", options: .literal, range: nil)
        .replacingOccurrences(of: "28", with: "២៨", options: .literal, range: nil)
        .replacingOccurrences(of: "29", with: "២៩", options: .literal, range: nil)
        .replacingOccurrences(of: "30", with: "៣០", options: .literal, range: nil)
        .replacingOccurrences(of: "31", with: "៣១", options: .literal, range: nil)
    
    return newTime
}
