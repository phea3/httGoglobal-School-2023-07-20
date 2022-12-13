//
//  FlashScreen.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 5/10/22.
//

import SwiftUI

struct FlashScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @State var animationFinished: Bool
    var language: String
    var prop: Properties
    var body: some View {
        ZStack{
            Color(colorScheme == .dark ? .black : .white)
                .ignoresSafeArea()
            ImageBackgroundSignIn()
            VStack{
                Spacer()
                LogoGoglobal(prop:prop)
                Spacer()
                footer(prop: prop)
//                if prop.isLandscape{
//                    Spacer()
//                }
            }
            .padding(prop.isiPhoneS ? 25: prop.isiPhoneM ? 30 : prop.isiPhoneL ? 35 : 40)
        }
        .opacity(animationFinished ? 0:1)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 0.7)){
                    animationFinished = true
                }
            }
        }
    }
    func footer(prop:Properties)-> some View{
        VStack(spacing:  prop.isiPhoneS ? 1 : prop.isiPhoneM ? 2 : prop.isiPhoneL ? 3 : 10){
            FooterImg(prop: prop)
                .padding(.top, 8)
        }
    }
}

struct FlashScreen_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        FlashScreen(animationFinished: false, language: "em", prop: prop)
    }
}
