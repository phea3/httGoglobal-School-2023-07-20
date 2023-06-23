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
    @StateObject var getallPermission: GetStudenAttendancePermissionByIdViewModel = GetStudenAttendancePermissionByIdViewModel()
    @State var loadingScreen: Bool = false
    @State var goToViewPermissionForm: Bool = false
    @State var currentProgress: CGFloat = 0
    @State var studentId: String
    @State var limit: Int = 10
    var parentId: String
    var classId: String
    var academicYearId: String
    var programId: String
    var prop: Properties
    var language: String
    var btnBack : some View { Button(action:{self.presentationMode.wrappedValue.dismiss()}) {backButtonView(language: self.language, prop: prop, barTitle: "សុំច្បាប់".localizedLanguage(language: self.language))}}
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
                    if getallPermission.GetAllPersmission.isEmpty{
                        VStack{
                            Text("មិនមានទិន្នន័យ!".localizedLanguage(language: self.language))
                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16 , relativeTo: .largeTitle))
                                .padding()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .onTapGesture(count: 2) {
                            getallPermission.getAllPermission(studentId: studentId, limit: self.limit)
                        }
                    } else {
                        ScrollView(.vertical, showsIndicators: false){
                            ForEach(getallPermission.GetAllPersmission, id: \.id){ item in
                                NavigationLink(destination: ViewPermission(shiftName: item.shiftName, reason: item.reason, startDate: item.startDate, endDate: item.endDate, requestDate: item.requestDate, prop: prop, language: language)) {
                                    HStack{
                                        VStack(alignment: .leading, spacing: 0){
                                            Text(item.shiftName)
                                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14 , relativeTo: .largeTitle))
                                                .foregroundColor(.gray)
                                            Text(item.startDate == item.endDate ? "\(convertStringToDateAndBackToString(inputDate: item.startDate))":"\(convertStringToDateAndBackToString(inputDate: item.startDate)) ~ \(convertStringToDateAndBackToString(inputDate: item.endDate))")
                                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 :  14 , relativeTo: .largeTitle))
                                                .foregroundColor(.black)
                                            Text(item.reason)
                                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14 , relativeTo: .largeTitle))
                                                .foregroundColor(.gray)
                                        }
                                        .foregroundColor(.gray)
                                        .padding(10)
                                        Spacer()
                                        
                                        Text(convertStringToDateAndBackToString(inputDate: item.requestDate))
                                            .foregroundColor(Color("bodyBlue"))
                                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14 , relativeTo: .largeTitle))
                                            .padding(10)
                                            .background(Color("LightBlue"))
                                            .cornerRadius(10)
                                            .padding(10)
                                    }
                                    .hLeading()
                                    .background(Color(colorScheme == .dark ? "Black" : "White" ))
                                    .cornerRadius(15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(.orange, lineWidth: colorScheme == .dark ? 1 : 0)
                                    )
                                }
                            }
                            if getallPermission.GetAllPersmission.count > 10  {
                                Button {
                                    DispatchQueue.main.async {
                                        self.limit += 10
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                        getallPermission.getAllPermission(studentId: studentId, limit: self.limit)
                                    }
                                } label: {
                                    Text("see more".localizedLanguage(language: self.language))
                                        .padding()
                                }
                            }
                        }
                        .padding(.top)
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    }
                }
                .frame(maxWidth:.infinity, maxHeight: .infinity)
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
            
            NavigationLink(destination: PermissionView(studentId: studentId, prop: prop, language: language, parentId: parentId), isActive: $goForPermission) {
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
            getallPermission.getAllPermission(studentId: studentId, limit: self.limit)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.loadingScreen = false
            }
        })
    }
    private func convertStringToDateAndBackToString(inputDate: String) -> String{
        let isoDate = inputDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:isoDate)!
        let StringFormatter =  DateFormatter()
        StringFormatter.locale = Locale(identifier: "en_US_POSIX")
        StringFormatter.dateFormat = "dd MMM, yyyy"
        let stringed = StringFormatter.string(from: date)
        return stringed
    }
}


struct PermissionView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var getStudentShift: GetShiftByStudentIdViewModel = GetShiftByStudentIdViewModel()
    @StateObject var askPermission: LeaveMutationViewModel = LeaveMutationViewModel()
    @State var fakeLoading: Bool = false
    @State private var shiftName = ""
    @State var allDay: Bool = false
    @State var goToViewPermissionForm: Bool = false
    @State var openFullSheet: Bool = false
    @State private var startDate = Date.now
    @State private var endDate = Date.now
    @State var reason: String = ""
    @State var shiftId: String = ""
    var studentId: String
    var prop: Properties
    var language: String
    var parentId: String
    var btnBack : some View { Button(action:{self.presentationMode.wrappedValue.dismiss()}) {backButtonView(language: self.language, prop: prop, barTitle: "ស្នើសុំច្បាប់".localizedLanguage(language: self.language))}}
    var body: some View{
        VStack{
            Divider()
            ZStack{
                VStack{
                    HStack{
                        Image(systemName: "note.text.badge.plus")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(.blue)
                            .cornerRadius(5)
                        Text("ប្រភេទនៃថ្ងៃឈប់សម្រាក".localizedLanguage(language: self.language))
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14 , relativeTo: .largeTitle))
                        Spacer()
                        Picker("Select type", selection: $shiftId) {
                            Text("ជ្រើសរើស".localizedLanguage(language: self.language))
                                .tag(Optional<String>(nil))
                            ForEach(getStudentShift.GetAllShift, id: \.shiftId) { item in
                                Text("\(item.shiftName)")
                                    .tag(Optional(item.shiftId))
                            }
                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(5)
                    .padding(.horizontal)
                    
                    HStack{
                        Image(systemName: "note.text.badge.plus")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(.blue)
                            .cornerRadius(5)
                        Text("ថ្ងៃចាប់ផ្តើម".localizedLanguage(language: self.language))
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14 , relativeTo: .largeTitle))
                        Spacer()
                        
                        DatePicker("",selection: $startDate, in: Date()..., displayedComponents: [.date])
                        
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    HStack{
                        Image(systemName: "note.text.badge.plus")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(.blue)
                            .cornerRadius(5)
                        Text("ថ្ងៃបញ្ចប់".localizedLanguage(language: self.language))
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14 , relativeTo: .largeTitle))
                        Spacer()
                        DatePicker("",selection: $endDate, in: Date()..., displayedComponents: [.date])
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    HStack{
                        Image(systemName: "note.text.badge.plus")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(.blue)
                            .cornerRadius(5)
                        TextField("មូលហេតុ", text: $reason)
                        Spacer()
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    if ((!reason.isEmpty && !parentId.isEmpty) && (!studentId.isEmpty && !shiftId.isEmpty)){
                        Button(action: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                askPermission.creatLeaveRequest(startDate: convertString(inputDate: self.startDate), endDate: convertString(inputDate: self.endDate), reason: self.reason, parentId: self.parentId, studentId: studentId, shiftId: self.shiftId)
                                openFullSheet = true
                            }
                        }, label: {
                            HStack{
                                Text("ស្នើសុំ".localizedLanguage(language: self.language))
                            }
                            .font(.custom("Bayon", size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : 18 , relativeTo: .largeTitle))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(.blue)
                            .cornerRadius(15)
                            .padding(.horizontal)
                            .padding(.bottom,60)
                        })
                        .sheet(isPresented: $openFullSheet) {
                            ViewDetain(shiftName: askPermission.shiftName, requestDate: askPermission.requestDate, startDate: askPermission.startDate, endDate: askPermission.endDate, prop: prop)
                        }
                    }else{
                        HStack{
                            Text("ស្នើសុំ".localizedLanguage(language: self.language))
                        }
                        .font(.custom("Bayon", size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : 18 , relativeTo: .largeTitle))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(.gray)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .padding(.bottom,60)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .setBG(colorScheme: colorScheme)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            getStudentShift.GetShiftNameAndId(studentId: studentId)
        }
    }
    
    private func ViewDetain(shiftName: String,requestDate: String, startDate: String, endDate: String, prop: Properties) -> some View {
        VStack{
            HStack{
                Text("ថ្ងៃស្នើសុំសម្រាក".localizedLanguage(language: self.language))
                    .foregroundColor(.gray)
                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14 , relativeTo: .largeTitle))
                Spacer()
                Text(convertStringToDateAndBackToString(inputDate: requestDate))
                    .foregroundColor(.gray)
                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14 , relativeTo: .largeTitle))
            }
            .padding(.top)
            Divider()
            HStack{
                Rectangle()
                    .fill(.blue)
                    .frame(width: 10, height: 80)
                VStack(alignment: .leading){
                    Text(startDate == endDate ? convertStringToDateAndBackToString(inputDate: startDate) : "\(convertStringToDateAndBackToString(inputDate: startDate)) ~ \(convertStringToDateAndBackToString(inputDate: endDate))")
                        .foregroundColor(.black)
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16 , relativeTo: .largeTitle))
                    Text(shiftName)
                        .foregroundColor(.black)
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14 , relativeTo: .largeTitle))
                }
                .padding(10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("LightBlue"))
            Divider()
            VStack(alignment: .leading){
                Text("មូលហេតុ".localizedLanguage(language: self.language))
                    .foregroundColor(.gray)
                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16 , relativeTo: .largeTitle))
                Text(reason)
                    .foregroundColor(.black)
                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14 , relativeTo: .largeTitle))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            VStack(alignment: .leading){
                Text("ស្ថានភាព".localizedLanguage(language: self.language))
                    .foregroundColor(.gray)
                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16 , relativeTo: .largeTitle))
                Text("\(Image(systemName: "checkmark.circle")) \("ស្នើសុំសម្រាកជោគជ័យ".localizedLanguage(language: self.language))")
                    .foregroundColor(.green)
                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14 , relativeTo: .largeTitle))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                    self.presentationMode.wrappedValue.dismiss()
                    askPermission.clearCache()
                }
                openFullSheet = false
            } label: {
                Text("រួចរាល់".localizedLanguage(language: self.language))
                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : 18 , relativeTo: .largeTitle))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(.blue)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.bottom,60)
            }
            
        }
        .frame(width: .infinity, height: .infinity)
        .padding(.horizontal)
        .padding(.bottom, 40)
        
    }
    
    private func convertString(inputDate: Date) -> String {
        let date = inputDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let string = dateFormatter.string(from: date)
        return string
    }
    
    private func convertStringToDateAndBackToString(inputDate: String) -> String{
        let isoDate = inputDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:isoDate) ?? Date()
        let StringFormatter =  DateFormatter()
        StringFormatter.locale = Locale(identifier: "en_US_POSIX")
        StringFormatter.dateFormat = "dd MMM, yyyy"
        let stringed = StringFormatter.string(from: date)
        return stringed
    }
}
