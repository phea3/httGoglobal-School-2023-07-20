//
//  Payment.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 1/10/22.
//

import SwiftUI

struct Payment: View {
    var prop: Properties
    var body: some View {
        VStack{
            rowView(dater: "កាលបរិច្ឆេត", pay: "បង់ថ្លៃ", period: "បរិយាយ", total: "សរុប")
                .padding()
            ScrollView(.vertical, showsIndicators: false) {
                rowdata(dater: "22-03-01", pay: "ថ្លៃអាហារ", period: "1Year", total: "$140")
                rowdata(dater: "22-03-01", pay: "ថ្លៃអាហារ", period: "1Year", total: "$140")
                rowdata(dater: "22-03-01", pay: "ថ្លៃអាហារ", period: "1Year", total: "$140")
                rowdata(dater: "22-03-01", pay: "ថ្លៃអាហារ", period: "1Year", total: "$140")
            }
            .padding(.horizontal)
        }
        .setBG()
    }
    func rowView(dater: String, pay: String, period: String, total: String)-> some View {
        HStack{
            Text(dater)
            Spacer()
            Text(pay)
            Spacer()
            Text(period)
            Spacer()
            Text(total)
        }
        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 11 : prop.isiPhoneM ? 13 : 15, relativeTo: .body))
        .foregroundColor(.blue)
        .padding()
        .frame(maxWidth:.infinity, maxHeight:50)
        .background(Color("LightBlue"))
        .cornerRadius(10)
        
    }
    func rowdata(dater: String, pay: String, period: String, total: String)-> some View {
        HStack{
            Image(systemName: "calendar.badge.clock")
            Text(dater)
            Spacer()
            Text(pay)
            Spacer()
            Text(period)
            Spacer()
            Text(total)
        }
        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 11 : prop.isiPhoneM ? 13 : 15, relativeTo: .body))
        .foregroundColor(.blue)
        .padding()
        .frame(maxWidth:.infinity, maxHeight:50)
        .background(Color("LightOrange").opacity(0.4))
        .cornerRadius(10)
        
    }
}

struct Payment_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Payment(prop: prop)
    }
}
