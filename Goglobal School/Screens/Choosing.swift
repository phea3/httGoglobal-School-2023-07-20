//
//  Choosing.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI

struct Choosing: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var chose: Chose
    @State var studentId: String
    let gradient = Color("BG")
    var barTitle: String
    var prop: Properties
    var classId: String
    var academicYearId: String
    var programId: String
    var btnBack : some View { Button(action:{self.presentationMode.wrappedValue.dismiss()}) {backButtonView(prop: prop, barTitle: barTitle).opacity((prop.isiPhoneL && prop.isLandscape) || (prop.isiPad || prop.isSplit)  ? 0:1)}}
    
    var body: some View {
        VStack(spacing: 0){
            Divider()
            TabView(selection: $chose){
                Schedule(prop: prop,classId: classId, academicYearId: academicYearId, programId: programId)
                    .tag(Chose.attendance)
                Attendant(studentId: studentId,prop: prop)
                    .tag(Chose.absence)
                Text("Payment")
                    .tag(Chose.payment)
                Text("Score")
                    .tag(Chose.score)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .setBG()
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
    }
}

struct Choose_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Choosing(chose: .attendance, studentId: "", barTitle: "",prop: prop,classId: "",academicYearId: "",programId: "")
    }
}
