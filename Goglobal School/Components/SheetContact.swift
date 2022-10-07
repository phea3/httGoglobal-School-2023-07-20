//
//  SheetContact.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 27/8/22.
//

import SwiftUI

struct SheetContact: View {
    @Environment(\.dismiss) var dismiss
    var prop: Properties
    var body: some View {
        ScrollView{
            Button("ចាកចេញ") {
                dismiss()
            }
            .font(.custom("Bayon", size: prop.isiPhoneS ? 20 : prop.isiPhoneM ? 24 : prop.isiPhoneL ? 26 : 30, relativeTo: .largeTitle))
            .foregroundColor(.red)
            .padding()
            Text("សូមទំនាក់ទំនងតាមពត័មានខាងក្រោម")
                .font(.custom("Bayon", size: prop.isiPhoneS ? 20 : prop.isiPhoneM ? 24 : prop.isiPhoneL ? 26 : 30, relativeTo: .largeTitle))
                .foregroundColor(Color("Blue"))
                .padding()
            VStack(alignment: .leading){
                HStack{
                    Image("facebook")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: prop.isiPhoneS ? 20 : prop.isiPhoneM ? 24 : prop.isiPhoneL ? 26 : 30)
                    Text("https://www.facebook.com/goglobalschool15/")
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18, relativeTo: .body))
                }
                
                HStack{
                    Image("envelope")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: prop.isiPhoneS ? 20 : prop.isiPhoneM ? 24 : prop.isiPhoneL ? 26 : 30)
                    Text("info@go-globalschool.com")
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18, relativeTo: .body))
                }
                
                HStack{
                    Image("phone-call")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: prop.isiPhoneS ? 20 : prop.isiPhoneM ? 24 : prop.isiPhoneL ? 26 : 30)
                    Text("063 5066 999/ 017 60 44 26/ 017 511 168/ 010 537 695")
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18, relativeTo: .body))
                }
                HStack{
                    Image("world")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: prop.isiPhoneS ? 20 : prop.isiPhoneM ? 24 : prop.isiPhoneL ? 26 : 30)
                    Text("https://www.go-globalschool.com")
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18, relativeTo: .body))
                }
                HStack{
                    Image("location-alt")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: prop.isiPhoneS ? 20 : prop.isiPhoneM ? 24 : prop.isiPhoneL ? 26 : 30)
                    Text("Thmey Village, Sangkut Svay Dangkum, Krong Siem Reap, Siem Reap")
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18, relativeTo: .body))
                }
            }
        }
        .setBG()
    }
}

struct SheetContact_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        SheetContact( prop: prop)
    }
}
