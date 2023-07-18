//
//  Attendant.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI

struct Attendant: View {
    @Environment(\.colorScheme) var colorScheme
    @State var currentDate: Date = Date()
    @State private var date = Date()
    @State var studentId: String
    @StateObject var Attendance: ListAttendanceViewModel = ListAttendanceViewModel()
    @StateObject var AllClasses: ScheduleViewModel = ScheduleViewModel()
    @State var loadingScreen: Bool = false
    @State var currentProgress: CGFloat = 0
    var classId: String
    var academicYearId: String
    var programId: String
    var prop: Properties
    var language: String
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
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
                VStack(spacing: 0){
                    CustomDatePicker(studentId: studentId, currentDate: $currentDate,sectionShiftId: AllClasses.id, prop: prop, language: self.language)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .setBG(colorScheme: colorScheme)
        .onAppear(perform: {
            AllClasses.getClasses(classId: self.classId, academicYearId: self.academicYearId, programId: self.programId)
            self.loadingScreen = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.loadingScreen = false
            }
        })
    }
}

struct Attendant_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Attendant(studentId: "",classId: "",academicYearId: "",programId: "", prop: prop, language: "em")
    }
}


