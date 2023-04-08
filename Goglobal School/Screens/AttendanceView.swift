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
    @State var studentId: String
    @State var loadingScreen: Bool = false
    @State var currentProgress: CGFloat = 0
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
                ScrollView(.vertical, showsIndicators: false){
                    HStack {
                        Text("Date")
                            .foregroundColor(.white)
                            .padding()
                        Text("Morning")
                            .foregroundColor(.white)
                            .padding()
                        Text("Afternoon")
                            .foregroundColor(.white)
                            .padding()
                        Text("Status")
                            .foregroundColor(.white)
                            .padding()
                    }
                    .background(.cyan)
                    .cornerRadius(10)
                    .padding(.top,10)
                    reportData(date: "05, Apr 2023", time1: "06:53", time2: "-", time3: "7:41", time4: "06:53", time5: "-", time6: "7:41", status: "Null")
                    reportData(date: "05, Apr 2023", time1: "06:53", time2: "-", time3: "7:41", time4: "06:53", time5: "-", time6: "7:41", status: "Null")
                    reportData(date: "05, Apr 2023", time1: "06:53", time2: "-", time3: "7:41", time4: "06:53", time5: "-", time6: "7:41", status: "Null")
                    reportData(date: "05, Apr 2023", time1: "06:53", time2: "-", time3: "7:41", time4: "06:53", time5: "-", time6: "7:41", status: "Null")
                    reportData(date: "05, Apr 2023", time1: "06:53", time2: "-", time3: "7:41", time4: "06:53", time5: "-", time6: "7:41", status: "Null")
                    reportData(date: "05, Apr 2023", time1: "06:53", time2: "-", time3: "7:41", time4: "06:53", time5: "-", time6: "7:41", status: "Null")
                }
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
                    .padding()
                VStack{
                    Text(time1)
                    Text(time2)
                    Text(time3)
                }
                .padding()
                VStack{
                    Text(time4)
                    Text(time5)
                    Text(time6)
                }
                .padding()
                Text(status)
                    .padding()
                
            }
           Divider()
        }
    }
}

