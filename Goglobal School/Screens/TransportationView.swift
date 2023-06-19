//
//  Transportation.swift
//  Goglobal School
//
//  Created by Macmini on 31/5/23.
//

import SwiftUI

struct TransportationView: View {
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
    @State var reloadimgtoolbar: Bool = false
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
        if #available(iOS 16, *) {
            NavigationStack  {
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
                                        .padding(.bottom, prop.isiPhoneS ? 65 : prop.isiPhoneM ? 75 : prop.isiPhoneL ? 85 : 100)
                                        .padding(.horizontal, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                                        .navigationBarTitleDisplayMode(.inline)
                                        .toolbar {
                                            ToolbarItem(placement: .navigationBarLeading) {
                                                HStack{
                                                    Image(systemName: "line.3.horizontal.decrease")
                                                        .padding(.bottom, prop.isiPhoneS ? 3 : prop.isiPhoneM ? 4 : prop.isiPhoneL ? 5 : 5)
                                                    Text("សេវាកម្មដឹកជញ្ជូន".localizedLanguage(language: language))
                                                        .font(.custom("Bayon", size: prop.isiPhoneS ? 15 : prop.isiPhoneM ? 16 :  prop.isiPhoneL ? 18 : 20, relativeTo: .largeTitle))
                                                }
                                                .foregroundColor(Color("Blue"))
                                                .padding(.vertical, prop.isLandscape ? 20 : 0)
                                            }
                                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                                ChangeLanguage()
                                            }
                                            ToolbarItem(placement: .navigationBarTrailing) {
                                                if prop.isLandscape{
                                                    HStack{
                                                        if self.reloadimgtoolbar{
                                                            ProgressView()
                                                                .onAppear{
                                                                    self.reloadimgtoolbar = false
                                                                }
                                                        } else {
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
                                                                        .frame(width: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 :  20, alignment: .center)
                                                                case .failure:
                                                                    Image(systemName: "person.fill")
                                                                        .padding(5)
                                                                        .background(Color.white)
                                                                        .overlay {
                                                                            Circle()
                                                                                .stroke(.orange, lineWidth: 1)
                                                                        }
                                                                        .aspectRatio(contentMode: .fill)
                                                                        .clipShape(Circle())
                                                                        .frame(width: prop.isLandscape ? 14 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : prop.isiPhoneL ? 20 : 22), alignment: .center)
                                                                        .onAppear{
                                                                            if !userProfileImg.isEmpty{
                                                                                self.reloadimgtoolbar = true
                                                                            }
                                                                        }
                                                                    
                                                                @unknown default:
                                                                    fatalError()
                                                                    
                                                                }
                                                            }
                                                        }
                                                    }
                                                    .padding(.vertical, 10 )
                                                }else{
                                                    HStack{
                                                        if self.reloadimgtoolbar{
                                                            ProgressView()
                                                                .onAppear{
                                                                    self.reloadimgtoolbar = false
                                                                }
                                                        } else {
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
                                                                        .onAppear{
                                                                            if !userProfileImg.isEmpty{
                                                                                self.reloadimgtoolbar = true
                                                                            }
                                                                        }
                                                                @unknown default:
                                                                    fatalError()
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
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
        } else {
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
                                        .padding(.bottom, prop.isiPhoneS ? 65 : prop.isiPhoneM ? 75 : prop.isiPhoneL ? 85 : 100)
                                        .padding(.horizontal, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                                        .navigationBarTitleDisplayMode(.inline)
                                        .toolbar {
                                            ToolbarItem(placement: .navigationBarLeading) {
                                                HStack{
                                                    Image(systemName: "line.3.horizontal.decrease")
                                                        .padding(.bottom, prop.isiPhoneS ? 3 : prop.isiPhoneM ? 4 : prop.isiPhoneL ? 5 : 5)
                                                    Text("ឆ្នាំសិក្សា \(academicYearName)".localizedLanguage(language: language))
                                                        .font(.custom("Bayon", size: prop.isiPhoneS ? 15 : prop.isiPhoneM ? 16 :  prop.isiPhoneL ? 18 : 20, relativeTo: .largeTitle))
                                                }
                                                .foregroundColor(Color("Blue"))
                                                .padding(.vertical, prop.isLandscape ? 20 : 0)
                                            }
                                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                                ChangeLanguage()
                                            }
                                            ToolbarItem(placement: .navigationBarTrailing) {
                                                if prop.isLandscape{
                                                    HStack{
                                                        if self.reloadimgtoolbar{
                                                            ProgressView()
                                                                .onAppear{
                                                                    self.reloadimgtoolbar = false
                                                                }
                                                        } else {
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
                                                                        .frame(width: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 :  20, alignment: .center)
                                                                case .failure:
                                                                    Image(systemName: "person.fill")
                                                                        .padding(5)
                                                                        .background(Color.white)
                                                                        .overlay {
                                                                            Circle()
                                                                                .stroke(.orange, lineWidth: 1)
                                                                        }
                                                                        .aspectRatio(contentMode: .fill)
                                                                        .clipShape(Circle())
                                                                        .frame(width: prop.isLandscape ? 14 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : prop.isiPhoneL ? 20 : 22), alignment: .center)
                                                                        .onAppear{
                                                                            if !userProfileImg.isEmpty{
                                                                                self.reloadimgtoolbar = true
                                                                            }
                                                                        }
                                                                    
                                                                @unknown default:
                                                                    fatalError()
                                                                    
                                                                }
                                                            }
                                                        }
                                                    }
                                                    .padding(.vertical, 10 )
                                                }else{
                                                    HStack{
                                                        if self.reloadimgtoolbar{
                                                            ProgressView()
                                                                .onAppear{
                                                                    self.reloadimgtoolbar = false
                                                                }
                                                        } else {
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
                                                                        .onAppear{
                                                                            if !userProfileImg.isEmpty{
                                                                                self.reloadimgtoolbar = true
                                                                            }
                                                                        }
                                                                @unknown default:
                                                                    fatalError()
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
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
    }
    private func mainView()-> some View {
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
                                        destination: AttendanceTransportaion(userProfileImg: self.userProfileImg, studentId: student.Id, studentName: "\(student.Lastname) \(student.Firstname)", studentEnglishName: student.EnglishName, classId: "",academicYearId: "", programId: "", barTitle: "សេវាកម្មដឹកជញ្ជូន", language: self.language, prop: prop),
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
   
    private func refreshingView(){
        self.refreshing = true
        self.onAppearImg = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshing = false
        }
    }
    
    private func ChangeLanguage()-> some View {
        HStack{
            Menu {
                Button {
                    self.bindingLanguage = "km-KH"
                } label: {
                    Text("ភាសាខ្មែរ")
                    Image("km")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                Button {
                    self.bindingLanguage = "en"
                } label: {
                    Text("English(US)")
                    Image("en")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
               
                
            } label: {
                
                Image(language == "ch" ? "ch" : language == "km-KH" ? "km" : "en")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        Circle()
                            .stroke(.yellow, lineWidth: 1)
                    }
                    .padding(-5)
                    .frame(width: prop.isLandscape ? 14 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20), alignment: .center)
            }
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
            .padding(5)
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
}

struct TransportationView_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        TransportationView(userProfileImg: "", isLoading: .constant(false), bindingLanguage: .constant(""),showTeacherImage: .constant(false),UrlImg: .constant(""), parentId: "", academicYearName: "", language: "", prop: prop)
    }
}

