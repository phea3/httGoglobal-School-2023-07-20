//
//  ContentView.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appData : AppDataModel
    var body: some View {
        Home()
            .environmentObject(appData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
