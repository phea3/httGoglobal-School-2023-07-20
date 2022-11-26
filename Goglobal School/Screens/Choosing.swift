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
    var btnBack : some View { Button(action:{self.presentationMode.wrappedValue.dismiss()}) {backButtonView(language: self.language, prop: prop, barTitle: barTitle)}}
    var language: String
    var body: some View {
        VStack(spacing: 0){
            Divider()
            TabView(selection: $chose){
                Schedule(prop: prop,classId: classId, academicYearId: academicYearId, programId: programId, language: self.language)
                    .tag(Chose.attendance)
                Attendant(studentId: studentId,classId: self.classId,academicYearId: self.academicYearId,programId: self.programId, prop: prop, language: self.language)
                    .tag(Chose.absence)
                Payment(studentId: studentId, prop: prop, language: self.language)
                    .tag(Chose.payment)
                Babysitting(prop: prop, language: self.language, stuId: self.studentId)
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
        Choosing(chose: .attendance, studentId: "", barTitle: "", prop: prop,classId: "",academicYearId: "",programId: "", language: "em")
    }
}
