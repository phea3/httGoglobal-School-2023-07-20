//
//  Goglobal_SchoolApp.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI

@main
struct Goglobal_SchoolApp: App {
    @StateObject var appData: AppDataModel = AppDataModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appData)
                .onOpenURL { url in
                    if appData.checkDeepLink(url: url){
                        print("FROM DEEP LINK")
                    }else{
                        print("FALL BACK DEEP LINK")
                    }
                }
        }
    }
}
