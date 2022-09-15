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
    var prop: Properties
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 0){
                CustomDatePicker(studentId: studentId, currentDate: $currentDate,prop: prop)
                    .padding(.bottom, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 15 : prop.isiPhoneL ? 20 : 25)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .setBG()
        .onAppear(perform: {
            Attendance.GetAllAttendance(studentId: studentId)
        })
    }
}

struct Attendant_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Attendant(studentId: "",prop: prop)
    }
}

