//
//  AttendanceView.swift
//  Goglobal School
//
//  Created by Luon Sokphea on 6/4/23.
//

import SwiftUI

struct AttendanceView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var GetallAttendanceStudent: GetStudentAttendanceByStuIdViewModel = GetStudentAttendanceByStuIdViewModel()
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var date: Date = Calendar.current.date(byAdding: .hour, value: -12, to: Date())!
    @State private var limit: Int = 10
    @State var studentId: String
    @State var loadingScreen: Bool = false
    @State var currentProgress: CGFloat = 0
    var classId: String
    var academicYearId: String
    var programId: String
    var prop: Properties
    var language: String
    var studentName: String
    var studentEnglishName: String
    var btnBack : some View { Button(action:{self.presentationMode.wrappedValue.dismiss()}) { backButtonView(language: self.language, prop: prop, barTitle: "\("វត្តមានរបស់".localizedLanguage(language: self.language)) \( self.language == "en" ? studentEnglishName : studentName)") }}
    var body: some View{
        VStack(spacing:0){
            Divider()
            if loadingScreen {
                ProgressView(value: currentProgress, total: 1000)
                Spacer()
                    .onAppear{
                        self.currentProgress = 250
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            self.currentProgress = 500
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9){
                            self.currentProgress = 750
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            self.currentProgress = 1000
                        }
                    }
                
            } else {
                VStack() {
                    HStack(spacing: 0){
                        DatePicker("", selection: $startDate,in: ...endDate,displayedComponents: [.date])
                            .labelsHidden()
                            .accentColor(.blue)
                            .onChange(of: startDate, perform: { value in
                                GetallAttendanceStudent.getAllAttendance(studentId: self.studentId, limit: self.limit, startDate: convertString(inputDate: value), endDate: convertString(inputDate: self.endDate))
                            });
                        Spacer()
                        
                        Text("ដល់".localizedLanguage(language: self.language))
                            .font(.custom("Kantumruy", size:  prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16 , relativeTo: .largeTitle))
                        
                        Spacer()
                        
                        DatePicker("", selection: $endDate,in: startDate...,displayedComponents: [.date])
                            .labelsHidden()
                            .accentColor(.red)
                            .onChange(of: endDate, perform: { value in
                                GetallAttendanceStudent.getAllAttendance(studentId: self.studentId, limit: self.limit, startDate: convertString(inputDate: self.startDate), endDate: convertString(inputDate: value))
                            });
                    }
                    
                    HStack(spacing: 0){
                        HStack(spacing: 0){
                            Spacer()
                            Text("កាលបរិច្ឆេទ".localizedLanguage(language: self.language))
                                .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16 , relativeTo: .largeTitle))
                            Spacer()
                        }
                        .padding(.leading, 10)
                        .frame(width: prop.isiPhoneS ? 100.0 : prop.isiPhoneM ? 110.0 : prop.isiPhoneL ? 110.0 : 140.0 , alignment: .center)
                        Spacer()
                        Divider()
                            .background(Color.white)
                        VStack(spacing: 0){
                            Text("")
                            Text("ពេលព្រឹក".localizedLanguage(language: self.language))
                            Text("")
                        }
                        .font(.custom("Bayon", size:  prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16 , relativeTo: .largeTitle))
                        .frame(width: prop.isiPhoneS ? 65.0 : prop.isiPhoneM ? 75.0 : prop.isiPhoneL ? 85.0 : 105.0, alignment: .center)
                        Divider()
                            .background(Color.white)
                        VStack(spacing: 0){
                            Text("")
                            Text("ពេលរសៀល".localizedLanguage(language: self.language))
                            Text("")
                        }
                        .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16 , relativeTo: .largeTitle))
                        .frame(width: prop.isiPhoneS ? 70.0 : prop.isiPhoneM ? 80.0 : prop.isiPhoneL ? 90.0 : 110.0, alignment: .center)
                        Divider()
                            .background(Color.white)
                        Text("ស្ថានភាព".localizedLanguage(language: self.language))
                            .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16, relativeTo: .largeTitle))
                            .frame(width: prop.isiPhoneS ? 70.0 : prop.isiPhoneM ? 80.0 : prop.isiPhoneL ? 100.0 : 120.0, alignment: .center)
                    }
                    .frame(height: prop.isiPhoneS ? 30.0 : prop.isiPhoneM ? 40.0 : 50.0)
                    .background(Color("Blue"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    if GetallAttendanceStudent.GetAllAttendance.isEmpty{
                        VStack{
                            Text("មិនមានទិន្នន័យ!".localizedLanguage(language: self.language))
                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 :  16 , relativeTo: .largeTitle))
                                .padding()
                                .onTapGesture(count: 2) {
                                    GetallAttendanceStudent.getAllAttendance(studentId: self.studentId, limit: self.limit, startDate: convertString(inputDate: self.startDate), endDate: convertString(inputDate: self.endDate))
                                }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }else{
                        ScrollView(.vertical, showsIndicators: false){
                            VStack(spacing: 0){
                                ForEach(GetallAttendanceStudent.GetAllAttendance, id: \.id){ item in
                                    HStack(spacing: 0){
                                        HStack(spacing: 0){
                                            Spacer()
                                            Text(convertDate(inputDate: item.attendanceDate))
                                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14  , relativeTo: .largeTitle))
                                            Spacer()
                                        }
                                        .padding(.leading, 10)
                                        .frame(width: prop.isiPhoneS ? 100.0 : prop.isiPhoneM ? 110.0 : prop.isiPhoneL ? 110.0 : 140.0, alignment: .center)
                                        
                                        Spacer()
                                        
                                        ForEach(item.data, id: \.id) { medium in
                                            HStack(spacing: 0){
                                                
                                                if medium.id == "62e1fe173cdcd305193c183e" {
                                                    
                                                    VStack(spacing: 0){
                                                        Text(medium.morningCheckIn.isEmpty ? "--:--" : convertStringToDateAndBackToString(inputDate: medium.morningCheckIn))
                                                        Text("-")
                                                        Text(medium.morningCheckOut.isEmpty ? "--:--" : convertStringToDateAndBackToString(inputDate: medium.morningCheckOut))
                                                    }
                                                    .frame(width: prop.isiPhoneS ? 65.0 : prop.isiPhoneM ? 75.0 : prop.isiPhoneL ? 85.0 : 105.0, alignment: .center)
                                                    .foregroundColor(medium.status == "PERMISSION" ? .orange : .black)
                                                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14  , relativeTo: .largeTitle))
                                                    
                                                } else if medium.id == "61cc12c736a74a5ec1bce55a" {
                                                    
                                                    VStack(spacing: 0){
                                                        Text(medium.morningCheckIn.isEmpty ? "--:--" : convertStringToDateAndBackToString(inputDate: medium.morningCheckIn))
                                                        Text("-")
                                                        Text(medium.morningCheckOut.isEmpty ? "--:--" : convertStringToDateAndBackToString(inputDate: medium.morningCheckOut))
                                                    }
                                                    .frame(width: prop.isiPhoneS ? 65.0 : prop.isiPhoneM ? 75.0 : prop.isiPhoneL ? 85.0 : 105.0, alignment: .center)
                                                    .foregroundColor(.black)
                                                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14 , relativeTo: .largeTitle))
                                                    
                                                } else  if (medium.id == "62e1fe1f3cdcd305193c1a98" && (item.data.count < 2)) && medium.id != "61cc12c736a74a5ec1bce55a" {
                                                    
                                                    VStack(spacing: 0){
                                                        Text(medium.morningCheckIn.isEmpty ? "--:--" : convertStringToDateAndBackToString(inputDate: medium.morningCheckIn))
                                                        Text("-")
                                                        Text(medium.morningCheckOut.isEmpty ? "--:--" : convertStringToDateAndBackToString(inputDate: medium.morningCheckOut))
                                                    }
                                                    .foregroundColor(.black)
                                                    .frame(width: prop.isiPhoneS ? 70.0 : prop.isiPhoneM ? 80.0 : prop.isiPhoneL ? 90.0 : 110.0, alignment: .center)
                                                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14  , relativeTo: .largeTitle))
                                                    
                                                }
                                                
                                                if medium.id == "62e1fe1f3cdcd305193c1a98" {
                                                    
                                                    VStack(spacing: 0){
                                                        Text(medium.afternoonCheckIn.isEmpty ?  "--:--" : convertStringToDateAndBackToString(inputDate: medium.afternoonCheckIn))
                                                        Text("-")
                                                        Text(medium.afternoonCheckOut.isEmpty ? "--:--" : convertStringToDateAndBackToString(inputDate: medium.afternoonCheckOut))
                                                    }
                                                    .foregroundColor(medium.status == "PERMISSION" ? .orange : .black)
                                                    .frame(width: prop.isiPhoneS ? 70.0 : prop.isiPhoneM ? 80.0 : prop.isiPhoneL ? 90.0 : 110.0, alignment: .center)
                                                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14 , relativeTo: .largeTitle))
                                                    
                                                } else if medium.id == "61cc12c736a74a5ec1bce55a" {
                                                    
                                                    VStack(spacing: 0){
                                                        Text(medium.afternoonCheckIn.isEmpty ?  "--:--" : convertStringToDateAndBackToString(inputDate: medium.afternoonCheckIn))
                                                        Text("-")
                                                        Text(medium.afternoonCheckOut.isEmpty ? "--:--" : convertStringToDateAndBackToString(inputDate: medium.afternoonCheckOut))
                                                    }
                                                    .frame(width: prop.isiPhoneS ? 65.0 : prop.isiPhoneM ? 75.0 : prop.isiPhoneL ? 85.0 : 105.0, alignment: .center)
                                                    .foregroundColor(.black)
                                                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14  , relativeTo: .largeTitle))
                                                    
                                                } else if (medium.id == "62e1fe173cdcd305193c183e" && (item.data.count < 2)) && (medium.id != "61cc12c736a74a5ec1bce55a") {
                                                    VStack(spacing: 0){
                                                        Text(medium.afternoonCheckIn.isEmpty ?  "--:--" : convertStringToDateAndBackToString(inputDate: medium.afternoonCheckIn))
                                                        Text("-")
                                                        Text(medium.afternoonCheckOut.isEmpty ? "--:--" : convertStringToDateAndBackToString(inputDate: medium.afternoonCheckOut))
                                                    }
                                                    .frame(width: prop.isiPhoneS ? 65.0 : prop.isiPhoneM ? 75.0 : prop.isiPhoneL ? 85.0 : 105.0, alignment: .center)
                                                    .foregroundColor(.black)
                                                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14 , relativeTo: .largeTitle))
                                                }
                                            }
                                        }
                                        
                                        VStack(spacing: 0){
                                            ForEach(item.data, id: \.id) { medium in
                                                HStack{
                                                    Text(medium.id == "62e1fe1f3cdcd305193c1a98" ? "A.\(medium.status)" : medium.id == "62e1fe173cdcd305193c183e" ? "M.\(medium.status)" : medium.id == "61cc12c736a74a5ec1bce55a" ? "F.\(medium.status)" : "\(medium.status)" )
                                                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 8 : prop.isiPhoneM ? 10 : prop.isiPhoneL ? 12 : 14 , relativeTo: .largeTitle))
                                                        .foregroundColor(medium.status == "LATE" ? .green : medium.status == "PERMISSION" ? .orange : medium.status == "ABSENT" ? .red :  medium.status == "PRESENT" ? .blue : .black)
                                                }
                                                .frame(width: prop.isiPhoneS ? 70.0 : prop.isiPhoneM ? 80.0 : prop.isiPhoneL ? 100.0 : 120.0, alignment: .center)
                                            }
                                        }
                                    }
                                    Divider()
                                }
                            }
                            
                            if (limit <= GetallAttendanceStudent.GetAllAttendance.count) {
                                Button {
                                    DispatchQueue.main.async {
                                        self.limit += 10
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                        GetallAttendanceStudent.getAllAttendance(studentId: self.studentId, limit: self.limit, startDate: convertString(inputDate: self.startDate), endDate: convertString(inputDate: self.endDate))
                                    }
                                } label: {
                                    Text("see more".localizedLanguage(language: self.language))
                                        .padding()
                                }
                            }
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                .padding(.bottom, prop.isiPhoneS && !prop.isLandscape ? 20 : prop.isiPhoneM && !prop.isLandscape ? 30 : prop.isiPhoneL && !prop.isLandscape ? 40 : 0)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .setBG(colorScheme: colorScheme)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            self.loadingScreen = true
            GetallAttendanceStudent.getAllAttendance(studentId: studentId, limit: limit, startDate: convertString(inputDate: startDate), endDate: convertString(inputDate: endDate))
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.loadingScreen = false
            }
        })
    }
    private func convertStringToDateAndBackToString(inputDate: String) -> String{
        let isoDate = inputDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:isoDate)
        let StringFormatter =  DateFormatter()
        StringFormatter.locale = Locale(identifier: "en_US_POSIX")
        StringFormatter.dateFormat = "HH:mm"
        let stringed = StringFormatter.string(from: date ?? Date())
        return stringed
    }
    private func convertDate(inputDate: String) -> String{
        let isoDate = inputDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:isoDate)
        let StringFormatter =  DateFormatter()
        StringFormatter.locale = Locale(identifier: "en_US_POSIX")
        StringFormatter.dateFormat = "dd MMM yyyy"
        let stringed = StringFormatter.string(from: date ?? Date())
        return stringed
    }
    private func convertStringToDate(inputDate: String) -> Date{
        let isoDate = inputDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:isoDate)!
        return date
    }
    private func convertString(inputDate: Date) -> String{
        let isoDate = inputDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let stringed = dateFormatter.string(from: isoDate)
        return stringed
    }
}
