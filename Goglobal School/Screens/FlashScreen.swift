//
//  FlashScreen.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 5/10/22.
//

import SwiftUI

struct FlashScreen: View {
    @State var animationFinished: Bool
    var prop: Properties
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            Image(prop.isLandscape ? "GoGlobalSchool":"splash1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: prop.isLandscape ? 200 :.infinity, maxHeight:prop.isLandscape ? 200 : .infinity)
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
}

struct FlashScreen_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        FlashScreen(animationFinished: false, prop: prop)
    }
}
