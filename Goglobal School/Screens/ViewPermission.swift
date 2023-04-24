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
                    HStack{
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 10, height: 80)
                        VStack(alignment: .leading){
                            Text("Apr 13, 2023")
                            Text("Time off, Matermity leave")
                        }
                        .padding(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.gray.opacity(0.2))
                    Divider()
                    VStack(alignment: .leading){
                        Text("Reason")
                        Text("Testing app")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                    VStack(alignment: .leading){
                        Text("Manager response")
                        Text("Pending")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(width: .infinity, height: .infinity)
                .padding()
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
