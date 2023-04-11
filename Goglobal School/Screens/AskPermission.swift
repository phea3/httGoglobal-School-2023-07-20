//
//  AskPermission.swift
//  Goglobal School
//
//  Created by Macmini on 10/4/23.
//

import SwiftUI

struct AskPermissionView: View {
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
    enum status : String, CaseIterable {
            case all
            case pending
            case cancel
            case approve
        }
    @State var selectedItem = status.all
    @State var goForPermission: Bool = false
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
                VStack(spacing:0){
                    HStack{
                        Image(systemName: "note.text.badge.plus")
                        Text("Status")
                        Spacer()
                        Picker("Select status", selection: $selectedItem) {
                            ForEach(status.allCases, id: \.self) { item in
                                Text(item.rawValue.capitalized)
                            }
                        }
                    }.padding()
                    Divider()
                    ScrollView(.vertical, showsIndicators: false){
                        HStack{
                            VStack(alignment: .leading){
                                Text("Annual Leave")
                                Text("08/09/2023")
                                Text("Headached")
                            }
                            .padding(10)
                            Spacer()
                            VStack{
                                Text("Pending")
                                    .padding(5)
                                    .background(.yellow)
                                    .cornerRadius(5)
                            }
                            .padding(10)
                        }
                        .hLeading()
                        .background(Color(colorScheme == .dark ? "Black" : "White" ))
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.orange, lineWidth: colorScheme == .dark ? 1 : 0)
                        )
                        .padding()
                    }
                }
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        goForPermission =  true
                    } label: {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.blue)
                            .overlay {
                                Image(systemName: "plus")
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                            }
                    }
                    .padding()
                    .offset(x:0,y: -80)
                }
            }
            
            NavigationLink(destination: PermissionView(prop: prop, language: language), isActive: $goForPermission) {
                EmptyView()
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

struct PermissionView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    enum status : String, CaseIterable {
            case annual = "Annual Leave"
            case sick = "Sick Leave"
            case maternity = "Maternity Leave"
        }
    enum shift : String, CaseIterable {
            case morning
            case afternoon
        }
    @State var selectedItem = status.annual
    @State var shiftItem = shift.morning
    @State var allDay: Bool = false
    @State private var birthDate = Date.now
    @State var reason: String = ""
    var prop: Properties
    var language: String
    var btnBack : some View { Button(action:{self.presentationMode.wrappedValue.dismiss()}) {backButtonView(language: self.language, prop: prop, barTitle: "ស្នើសុំច្បាប់")}}
    var body: some View{
        VStack(spacing:0){
            Divider()
            HStack{
                Image(systemName: "note.text.badge.plus")
                Text("Type of time off")
                Spacer()
                Picker("Select type", selection: $selectedItem) {
                    ForEach(status.allCases, id: \.self) { item in
                        Text(item.rawValue.capitalized)
                    }
                }
            }.padding()
            Divider()
            HStack{
              Image(systemName: "clock")
                    .foregroundColor( allDay ? .black : .gray )
              Text("All Day")
                    .foregroundColor( allDay ? .black : .gray )
              Spacer()
                Toggle("", isOn: $allDay)
            }
            .padding()
            HStack{
              Image(systemName: "clock")
                    .opacity(0.0)
              Text("Date")
                    .foregroundColor(.black )
              Spacer()
               
            DatePicker(selection: $birthDate, in: Date()..., displayedComponents: .date){
//                Text("\(birthDate.formatted(date: .long, time: .omitted))")
            }
                Image(systemName: "calendar")
            }
            .padding()
            HStack{
                Image(systemName: "clock")
                    .opacity(0.0)
                Text("Shift")
                    .foregroundColor(.black )
                Spacer()
                Picker("Select", selection: $shiftItem){
                    ForEach(shift.allCases, id: \.self){ item in
                        Text(item.rawValue.capitalized)
                    }
                }
            }
            .padding()
            VStack{
                Divider()
                Text("")
                    .padding()
                Divider()
            }
           
            HStack{
                Image(systemName: "pencil")
                TextField("Reason", text: $reason)
                Spacer()
            }
            .padding()
            Divider()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .setBG(colorScheme: colorScheme)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
    }
}
