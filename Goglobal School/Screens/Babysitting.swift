//
//  Babysitting.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 24/10/22.
//

import SwiftUI

struct Babysitting: View {
    var prop: Properties
    var language: String
    var stuId: String
    var body: some View {
        VStack{
            CalendarWeekListViewModel(calendar: Calendar(identifier: .gregorian), prop: self.prop, stuId: self.stuId, language: self.language)
        }
        .setBG()
    }
}

struct Babysitting_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Babysitting(prop: prop, language: "km", stuId: "")
    }
}
