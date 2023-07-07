//
//  AttendanceTransportaion.swift
//  Goglobal School
//
//  Created by loun sokphea on 19/6/23.
//

import SwiftUI

struct AttendanceTransportaion: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var appState = AppState.shared
    @StateObject var SchoolBus: GetStudentTransportationAttendancePagination = GetStudentTransportationAttendancePagination()
    @State var userProfileImg: String
    @State private var startDate: Date = Calendar.current.date(byAdding: .hour, value: -12, to: Date())!
    @State private var endDate: Date = Calendar.current.date(byAdding: .hour, value: +12, to: Date())!
    @State private var date: Date = Calendar.current.date(byAdding: .hour, value: -12, to: Date())!
    @State private var limit: Int = 10
    @State private var page: Int = 1
    @State var studentId: String
    @State var loadingScreen: Bool = false
    @State var currentProgress: CGFloat = 0
    var barTitle: String
    var language: String
    var prop: Properties
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            DispatchQueue.main.async {
                appState.stu_id = nil
                appState.actionofnoty = nil
            }
        }) {
            backButtonView(language: self.language, prop: prop, barTitle: barTitle.localizedLanguage(language: self.language))
        }
    }
    var body: some View {
        VStack(spacing:0){
            Divider()
            if loadingScreen {
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
                
            } else {
                VStack{
                    HStack(spacing: 0){
                        DatePicker("", selection: $startDate,in: ...endDate,displayedComponents: [.date])
                            .labelsHidden()
                            .accentColor(.blue)
                            .onChange(of: startDate, perform: { value in
                                SchoolBus.getAttendances(page: self.page, limit: self.limit, start: convertString(inputDate: startDate), end: convertString(inputDate: self.endDate), busId: "", studentId: self.studentId)
                            });
                        Spacer()
                        
                        Text("ដល់".localizedLanguage(language: self.language))
                            .font(.custom("Kantumruy", size:  prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16 , relativeTo: .largeTitle))
                        
                        Spacer()
                        
                        DatePicker("", selection: $endDate,in: startDate...,displayedComponents: [.date])
                            .labelsHidden()
                            .accentColor(.red)
                            .onChange(of: endDate, perform: { value in
                                SchoolBus.getAttendances(page: self.page, limit: self.limit, start: convertString(inputDate: self.startDate), end: convertString(inputDate: endDate), busId: "", studentId: self.studentId)
                            });
                    }
                    
                    HStack(spacing: 0){
                        HStack(spacing: 0){
                            Spacer()
                            Text("កាលបរិច្ឆេទ".localizedLanguage(language: self.language))
                                .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16 , relativeTo: .largeTitle))
                            Spacer()
                        }
                        .padding(.leading, 10)
                        .frame(width: prop.isiPhoneS ? 100.0 : prop.isiPhoneM ? 110.0 : prop.isiPhoneL ? 110.0 : 140.0 , alignment: .center)
                        Spacer()
                        Divider()
                            .background(Color.white)
                        VStack(spacing: 0){
                            Text("")
                            Text("យកមកសាលា".localizedLanguage(language: self.language))
                            Text("")
                        }
                        .font(.custom("Bayon", size:  prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16 , relativeTo: .largeTitle))
                        .frame(width: prop.isiPhoneS ? 100.0 : prop.isiPhoneM ? 110.0 : prop.isiPhoneL ? 120.0 : 140.0, alignment: .center)
                        Divider()
                            .background(Color.white)
                        VStack(spacing: 0){
                            Text("")
                            Text("ជូនទៅផ្ទះ".localizedLanguage(language: self.language))
                            Text("")
                        }
                        .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16 , relativeTo: .largeTitle))
                        .frame(width: prop.isiPhoneS ? 95.0 : prop.isiPhoneM ? 105.0 : prop.isiPhoneL ? 115.0 : 135.0, alignment: .center)
                    }
                    .frame(height: prop.isiPhoneS ? 30.0 : prop.isiPhoneM ? 40.0 : 50.0)
                    .background(Color("ColorTitle"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    if SchoolBus.attendances.isEmpty{
                        VStack{
                            Text("មិនមានទិន្នន័យ!".localizedLanguage(language: self.language))
                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 :  16 , relativeTo: .largeTitle))
                                .padding()
                                .onTapGesture(count: 2) {
                                    SchoolBus.getAttendances(page: self.page, limit: self.limit, start: "", end: "", busId: "", studentId: self.studentId)
                                }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }else{
                        ScrollView(.vertical, showsIndicators: false){
                            VStack(spacing: 0){
                                ForEach(SchoolBus.attendances, id: \.id){ item in
                                    HStack(spacing: 0){
                                        HStack(spacing: 0){
                                            Spacer()
                                            Text(convertDate(inputDate: item.date))
                                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14  , relativeTo: .largeTitle))
                                            Spacer()
                                        }
                                        .foregroundColor(Color("ColorTitle"))
                                        .padding(.leading, 10)
                                        .frame(width: prop.isiPhoneS ? 100.0 : prop.isiPhoneM ? 110.0 : prop.isiPhoneL ? 110.0 : 140.0, alignment: .center)
                                        
                                        Spacer()
                                        
                                        VStack(spacing: 0){
                                            Text(" ")
                                            Text(item.checkIn.isEmpty ? "--:--" : item.checkIn)
                                            Text(" ")
                                        }
                                        .frame(width: prop.isiPhoneS ? 100.0 : prop.isiPhoneM ? 110.0 : prop.isiPhoneL ? 120.0 : 140.0, alignment: .center)
                                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14  , relativeTo: .largeTitle))
                                        
                                        VStack(spacing: 0){
                                            Text(" ")
                                            Text(item.checkOut.isEmpty ? "--:--" : item.checkOut)
                                            Text(" ")
                                        }
                                        .frame(width: prop.isiPhoneS ? 95.0 : prop.isiPhoneM ? 105.0 : prop.isiPhoneL ? 115.0 : 135.0, alignment: .center)
                                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14  , relativeTo: .largeTitle))
                                    }
                                    .frame(height: prop.isiPhoneS ? 30.0 : prop.isiPhoneM ? 40.0 : 50.0)
                                    Divider()
                                }
                            }
                            
                            if (SchoolBus.attendances.count > 10) {
                                Button {
                                    DispatchQueue.main.async {
                                        self.limit += 10
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                        SchoolBus.getAttendances(page: self.page, limit: self.limit, start: "", end: "", busId: "", studentId: self.studentId)
                                    }
                                } label: {
                                    Text("see more".localizedLanguage(language: self.language))
                                        .padding()
                                }
                            }
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationBarTitleDisplayMode(.inline)
        .setBG(colorScheme: colorScheme)
        .onAppear(perform: {
            SchoolBus.getAttendances(page: self.page, limit: self.limit, start: convertString(inputDate: self.startDate), end: convertString(inputDate: self.endDate), busId: "", studentId: self.studentId)
        })
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if prop.isLandscape{
                    HStack{
                        AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(userProfileImg)"), scale: 2){image in
                            
                            switch  image {
                                
                            case .empty:
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .frame(width: prop.isLandscape ? 30 : (prop.isiPhoneS ? 24 : prop.isiPhoneM ? 24 : 24), alignment: .center)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .background(Color.black.opacity(0.2))
                                    .overlay {
                                        Circle()
                                            .stroke(.orange, lineWidth: 1)
                                    }
                                    .clipShape(Circle())
                                    .padding(-5)
                                    .frame(width: prop.isLandscape ? 14 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20), alignment: .center)
                            case .failure:
                                Image(systemName: "person.fill")
                                    .padding(5)
                                    .font(.system(size:  prop.isLandscape ? 22 : (prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18)))
                                    .background(Color.white)
                                    .overlay {
                                        Circle()
                                            .stroke(.orange, lineWidth: 1)
                                    }
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .frame(width: prop.isLandscape ? 14 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20), alignment: .center)
                            @unknown default:
                                fatalError()
                            }
                        }
                    }
                } else {
                    HStack{
                        AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(userProfileImg)"), scale: 2){image in
                            
                            switch  image {
                                
                            case .empty:
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .frame(width: prop.isLandscape ? 30 : (prop.isiPhoneS ? 24 : prop.isiPhoneM ? 24 : 24), alignment: .center)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .background(Color.black.opacity(0.2))
                                    .overlay {
                                        Circle()
                                            .stroke(.orange, lineWidth: 1)
                                    }
                                    .clipShape(Circle())
                                    .padding(-5)
                                    .frame(width: prop.isLandscape ? 14 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20), alignment: .center)
                            case .failure:
                                Image(systemName: "person.fill")
                                    .padding(5)
                                    .font(.system(size:  prop.isLandscape ? 22 : (prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18)))
                                    .background(Color.white)
                                    .overlay {
                                        Circle()
                                            .stroke(.orange, lineWidth: 1)
                                    }
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .frame(width: prop.isLandscape ? 14 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20), alignment: .center)
                            @unknown default:
                                fatalError()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func convertDate(inputDate: String) -> String{
        let isoDate = inputDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from:isoDate) else { return "" }
        let StringFormatter =  DateFormatter()
        StringFormatter.locale = Locale(identifier: "en_US_POSIX")
        StringFormatter.dateFormat = "dd MMM yyyy"
        let stringed = StringFormatter.string(from: date)
        return stringed
    }
    
    private func convertString(inputDate: Date) -> String{
        let isoDate = inputDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let stringed = dateFormatter.string(from: isoDate)
        return stringed
    }
    
}
