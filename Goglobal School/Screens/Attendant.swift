//
//  Attendant.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI

struct Attendant: View {
    @State var currentDate: Date = Date()
    @State private var date = Date()
    @State var studentId: String
    @StateObject var Attendance: ListAttendanceViewModel = ListAttendanceViewModel()
    @State var loadingScreen: Bool = false
    @State var currentProgress: CGFloat = 0
    var prop: Properties
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            if loadingScreen{
                ProgressView(value: currentProgress, total: 1000)
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
                VStack(spacing: 0){
                    CustomDatePicker(studentId: studentId, currentDate: $currentDate,prop: prop)
                        .padding(.bottom,prop.isiPhoneS ? 10 : prop.isiPhoneM ? 15 : prop.isiPhoneL ? 20 : 25)
                        .padding(.horizontal, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .setBG()
        .onAppear(perform: {
            Attendance.GetAllAttendance(studentId: studentId)
            self.loadingScreen = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.loadingScreen = false
            }
        })
    }
}

struct Attendant_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Attendant(studentId: "",prop: prop)
    }
}

