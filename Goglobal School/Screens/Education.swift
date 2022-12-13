//
//  Education.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI

struct Education: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var students: ListStudentViewModel = ListStudentViewModel()
    @State var DummyBoolean: Bool = false
    @State var axcessPadding: CGFloat = 0
    @State var currentProgress: CGFloat = 0.0
    @State var userProfileImg: String
    @State var refreshing: Bool  = false
    @State var confirm: Bool = false
    @State var viewLoading: Bool = false
    @State var hidingDivider: Bool = false
    @State var onAppearImg: Bool = false
    @State private var reloadingImg: Bool = false
    @Binding var isLoading: Bool
    @Binding var bindingLanguage: String
    @Binding var showTeacherImage: Bool
    @Binding var UrlImg: String
    let gradient = Color("BG")
    var parentId: String
    var academicYearName: String
    var language: String
    var prop: Properties
    var body: some View {
        NavigationView  {
            VStack(spacing: 0) {
                if DummyBoolean{
                    ZStack{
                        if viewLoading{
                            progressingView(prop: prop,language: self.language, colorScheme: colorScheme)
                        }else{
                            Text("មិនមានទិន្ន័យ!".localizedLanguage(language: self.language))
                                .foregroundColor(.blue)
                        }
                    }
                    .onAppear{
                        self.viewLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            self.viewLoading = false
                        }
                    }
                }else if students.Error{
                    Text("សូមព្យាយាមម្តងទៀត".localizedLanguage(language: self.language))
                        .foregroundColor(.blue)
                }else{
                    Divider()
                        .opacity(hidingDivider ? 0:1)
                    if !refreshing{
                        
                        ZStack{
                            ScrollRefreshable(langauge: self.language,title: "កំពុងភ្ជាប់", tintColor: .blue) {
                                mainView()
                                    .navigationBarTitleDisplayMode(.inline)
                                    .toolbarView(prop: prop, barTitle: "ឆ្នាំសិក្សា \(academicYearName)", profileImg: userProfileImg, language: self.language)
                                    .toolbar {
                                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                                            ChangeLanguage()
                                        }
                                    }
                                    .padding(.bottom, prop.isiPhoneS ? 65 : prop.isiPhoneM ? 75 : prop.isiPhoneL ? 85 : 100)
                                    .padding(.horizontal, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                            }
                            if onAppearImg{
                                ZStack{
                                    Color(colorScheme == .dark ? "Black" : "BG")
                                        .frame(maxWidth:.infinity, maxHeight: .infinity)
                                    VStack{
                                        ProgressView(value: currentProgress, total: 1000)
                                            .onAppear{
                                                self.currentProgress = 250
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                                    self.currentProgress = 500
                                                }
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                                                    self.currentProgress = 750
                                                }
                                            }
                                        Spacer()
                                    }
                                    
                                }
                                
                            }
                        }
                    }else{
                        Spacer()
                        progressingView(prop: prop, language: self.language, colorScheme: colorScheme)
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .onAppear {
                students.StundentAmount(parentId: parentId)
            }
            .setBG(colorScheme: colorScheme)
        }
        .refreshable {
            do {
                students.clearCache()
                // Sleep for 2 seconds
                try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            } catch {}
            self.hidingDivider = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.hidingDivider = false
            }
            refreshingView()
            students.StundentAmount(parentId: parentId)
        }
        .phoneOnlyStackNavigationView()
        .padOnlyStackNavigationView()
       
        
    }
    @ViewBuilder
    private func mainView()-> some View{
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0){
                Text("បុត្រធីតា".localizedLanguage(language: self.language))
                    .foregroundColor(.blue)
                    .font(.custom("Bayon", size: prop.isiPhoneS ? 20 : prop.isiPhoneM ? 22 : prop.isiPhoneL ? 24:26, relativeTo: .largeTitle))
                    .hLeading()
                    .padding()
                    .background(.clear)
                ZStack {
                    imageStuBG(prop: prop)
                    if students.AllStudents.isEmpty{
                        Text("មិនមានកូន".localizedLanguage(language: self.language))
                            .foregroundColor(.blue)
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    if students.AllStudents.isEmpty{
                                        self.onAppearImg = false
                                    }
                                }
                            }
                    } else {
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: prop.isiPhoneS ? 8 : prop.isiPhoneM ? 10 : prop.isiPhoneL ? 12 : 14){
                                ForEach(students.AllStudents,id: \.Id){ student in
                                    NavigationLink(
                                        destination: Grade(studentId: student.Id, userProfileImg: userProfileImg, showTeacherImage: $showTeacherImage,UrlImg: $UrlImg, Student: "\(student.Lastname) \(student.Firstname)", StudentEnglishName: student.EnglishName, parentId: parentId, barTitle: "ឆ្នាំសិក្សា \(academicYearName)",studentID: student.Id, language: self.language, prop: prop),
                                        label: {
                                            widgetStu(ImageStudent: student.profileImage, Firstname: student.Firstname, Lastname: student.Lastname, prop: prop, Englishname: student.EnglishName)
                                        }
                                    )                            }
                            }
                            .frame(width: (prop.isLandscape && (prop.isiPhone || prop.isiPad)) || prop.isiPad ? prop.size.width : .infinity)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom)
                Divider()
            }
        }
       
    }
    func refreshingView(){
        self.refreshing = true
        self.onAppearImg = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshing = false
        }
    }
    func widgetStu(ImageStudent: String, Firstname: String, Lastname: String,prop:Properties, Englishname: String) -> some View {
        
        VStack(alignment: .center, spacing: 0){
            if reloadingImg{
                VStack{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .progressViewStyle(.circular)
                    Text("សូមរង់ចាំ".localizedLanguage(language: self.language))
                        .foregroundColor(.blue)
                }
                .frame(height: prop.isiPhoneS ? 140 : prop.isiPhoneM ? 150 : prop.isiPhoneL ? 170 : 180)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        self.reloadingImg = false
                    }
                }
            }else{
                AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(ImageStudent)"), scale: 2){image in
                    
                    switch  image {
                    case .empty:
                        VStack{
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .progressViewStyle(.circular)
                            Text("សូមរង់ចាំ".localizedLanguage(language: self.language))
                                .foregroundColor(.blue)
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .padding(prop.isiPhoneS ? 20 : prop.isiPhoneM ? 20 : prop.isiPhoneL ? 24 : 25)
                            .onAppear{
                                self.onAppearImg = false 
                            }
                    case .failure:
                        Image("student")
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fit)
                            .padding()
                            .onAppear{
                                self.onAppearImg = false
                                if !ImageStudent.isEmpty{
                                    self.reloadingImg = true
                                }
                            }
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(height: prop.isiPhoneS ? 140 : prop.isiPhoneM ? 150 : prop.isiPhoneL ? 170 : 180)
            }
            
            
            HStack{
                language == "en" ? Text(Englishname) :
                Text("\(Lastname) \(Firstname)")
            }
            .padding(2)
            .padding(.horizontal, 5)
            .font(.custom("kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16, relativeTo: .largeTitle))
            .background(colorScheme == .dark ? .clear : .blue)
            .cornerRadius(5)
            .padding(.bottom, 10)
        }
        .background(.clear)
        .foregroundColor(confirm ? .black : .white)
        .frame(width: prop.isiPhoneS ? 160 : prop.isiPhoneM ? 170 : prop.isiPhoneL ? 180 : 200, height: prop.isiPhoneS ? 185 : prop.isiPhoneM ? 200 : prop.isiPhoneL ? 220 : 220, alignment: .center)
        .addBorder(.orange,width: 1, cornerRadius: 20)
    }
    @ViewBuilder
    private func ChangeLanguage()-> some View {
        HStack{
            Menu {
                //                    Button {
                //                        self.language = "ch"
                //                    } label: {
                //                        Text("中文")
                //                    }
                Button {
                    // Step #3
                    self.bindingLanguage = "en"
                } label: {
                    Text("English(US)")
                    Image("en")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                Button {
                    self.bindingLanguage = "km-KH"
                } label: {
                    Text("ភាសាខ្មែរ")
                    Image("km")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                
            } label: {
                
                Image(language == "ch" ? "ch" : language == "km-KH" ? "km" : "en")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .overlay {
                        Circle()
                            .stroke(.yellow, lineWidth: 1)
                    }
            }
        }
    }
}

struct Education_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0.0, height:  0.0))
        Education(userProfileImg: "", isLoading: .constant(false), bindingLanguage: .constant(""),showTeacherImage: .constant(false),UrlImg: .constant(""), parentId: "", academicYearName: "", language: "", prop: prop)
    }
}
