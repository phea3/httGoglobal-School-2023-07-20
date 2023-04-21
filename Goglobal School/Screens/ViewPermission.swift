//
//  ViewPermission.swift
//  Goglobal School
//
//  Created by Macmini on 21/4/23.
//

import SwiftUI

struct ViewPermission: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var loadingScreen: Bool = false
    @State var currentProgress: CGFloat = 0
    @State var studentId: String
    var classId: String
    var academicYearId: String
    var programId: String
    var prop: Properties
    var language: String
    var btnBack : some View { Button(action:{self.presentationMode.wrappedValue.dismiss()}) {backButtonView(language: self.language, prop: prop, barTitle: "សុំច្បាប់")}}
    var body: some View {
        VStack(spacing:0){
            Divider()
            if loadingScreen{
                ProgressView(value: currentProgress, total: 1000)
                Spacer()
                    .onAppear{
                        self.currentProgress = 250
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            self.currentProgress = 500
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9){
                            self.currentProgress = 750
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            self.currentProgress = 1000
                        }
                    }
                
            }else{
                VStack{
                    HStack{
                        Text("Time off request")
                        Spacer()
                        Text("Mar 31 23")
                    }
                    Divider()
                    VStack{
                        Text("Reason")
                        Text("Testing app")
                    }
                    Divider()
                    VStack{
                        Text("Manager response")
                        Text("Pending")
                    }
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .setBG(colorScheme: colorScheme)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            self.loadingScreen = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.loadingScreen = false
            }
        })
    }
    
}
