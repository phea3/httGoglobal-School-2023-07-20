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
    @State var currentDate: Date = Date()
    @State private var date = Date()
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State var studentId: String
    @State var loadingScreen: Bool = false
    @State var currentProgress: CGFloat = 0
    @State var media = [
        Media(id: 0, date: "05, Apr 2023", morning: "06:53", afternoon: "01:53", status: "Present"),
        Media(id: 1, date: "06, Apr 2023", morning: "07:53", afternoon: "02:53", status: "Present"),
        Media(id: 2, date: "07, Apr 2023", morning: "08:53", afternoon: "03:53", status: "Present"),
        Media(id: 3, date: "08, Apr 2023", morning: "09:53", afternoon: "04:53", status: "Present"),
        Media(id: 4, date: "09, Apr 2023", morning: "10:53", afternoon: "05:53", status: "Present"),
        Media(id: 5, date: "10, Apr 2023", morning: "11:53", afternoon: "06:53", status: "Present"),
        Media(id: 6, date: "11, Apr 2023", morning: "12:53", afternoon: "07:53", status: "Present")
    ]
    var classId: String
    var academicYearId: String
    var programId: String
    var prop: Properties
    var language: String
    var btnBack : some View { Button(action:{self.presentationMode.wrappedValue.dismiss()}) {backButtonView(language: self.language, prop: prop, barTitle: "វត្តមាន")}}
    var body: some View{
        VStack(spacing:0){
            Divider()
            if loadingScreen{
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
                
            }else{
                VStack() {
                    HStack(spacing: 0){
                        DatePicker(selection: $startDate, in: ...Date.now, displayedComponents: .date) {
                            Text("Select a date")
                        }.labelsHidden()
                        Spacer()
                        Text("To")
                        Spacer()
                        DatePicker(selection: $endDate, in: ...Date.now, displayedComponents: .date) {
                            Text("Select a date")
                        }.labelsHidden()
                    }
                    
                    HStack{
                        Text("Date")
                            .padding(.leading, 10)
                            .frame(width: 120.0, alignment: .leading)
                        Spacer()
                        Divider()
                        VStack{
                            Text("")
                            Text("Morning")
                            Text("")
                        }
                        .frame(width: 80.0, alignment: .center)
                        Divider()
                        VStack{
                            Text("")
                            Text("Afternoon")
                            Text("")
                        }
                        .frame(width: 80.0, alignment: .center)
                        Divider()
                        Text("status")
                            .frame(width: 70.0, alignment: .center)
                    }
                        .frame(height: 60)
                        .background(.cyan)
                        .cornerRadius(10)
                   
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(media, id: \.id){ item in
                            reportData(date: item.date, time1: item.morning, time2: "-", time3: item.morning, time4: item.afternoon, time5: "-", time6: item.afternoon, status: item.status)
                        }
                    }
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .setBG(colorScheme: colorScheme)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            self.loadingScreen = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.loadingScreen = false
            }
        })
    }
    
    func reportData(date:String,time1:String,time2:String,time3:String,time4:String,time5:String,time6:String,status:String)-> some View {
        VStack{
            HStack{
                Text(date)
                    .padding(.leading, 10)
                    .frame(width: 120.0, alignment: .leading)
                Spacer()
                Divider()
                VStack{
                    Text(time1)
                    Text(time2)
                    Text(time3)
                }
                .frame(width: 80.0, alignment: .center)
                Divider()
                VStack{
                    Text(time4)
                    Text(time5)
                    Text(time6)
                }
                .frame(width: 80.0, alignment: .center)
                Divider()
                Text(status)
                    .frame(width: 70.0, alignment: .center)
            }
            Divider()
        }
    }
}

struct Media {
    
    var id: Int
    var date: String
    var morning: String
    var afternoon: String
    var status: String
    
    //    init(id: Int, name: String) {
    //        self.id = id
    //        self.name = name
    //    }
}
