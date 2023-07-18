//
//  Dashboard.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI
import MarqueeText
import ActivityIndicatorView
struct Dashboard: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var totalStu: GetTotalStudentViewModel = GetTotalStudentViewModel()
    @StateObject var students: ListStudentViewModel = ListStudentViewModel()
    @StateObject var academiclist: ListViewModel = ListViewModel()
    @StateObject var AnnoucementList: AnnouncementViewModel = AnnouncementViewModel()
    @State private var reloadingImg: Bool = false
    @State private var reloadingAnn: Bool = false
    @State var colorBlue: String = "LightBlue"
    @State var colorOrg: String = "LightOrange"
    @State var ImageStudent: String = ""
    @State var NameStudent: String = ""
    @State var detailId: String =  ""
    @State var userProfileImg: String
    @State var showingSheet: Bool = false
    @State var onAppearImg: Bool = true
    @State var tooltipVisible: Bool = false
    @State var refreshing: Bool = false
    @State var viewLoading: Bool = false
    @State var timingShow: Int = 0
    @State var hidingDivider: Bool = false
    @State var currentProgress: CGFloat = 0.0
    @State var reloadimgtoolbar: Bool = false
    @Binding var isLoading: Bool
    @Binding var bindingLanguage: String
    @Binding var showTeacherImage: Bool
    @Binding var UrlImg: String
    let gradient = Color.clear
    var barTitle: String = "ទំព័រដើម"
    var parentId: String
    var activeYear: String
    var prop: Properties
    var mobileUserId: String
    var language: String
    
    var body: some View {
        if #available(iOS 16, *) {
            
            NavigationStack{
                
                VStack(spacing:0){
                    if students.AllStudents.isEmpty && AnnoucementList.Annouces.isEmpty && academiclist.academicYear.isEmpty {
                        ZStack{
                            if viewLoading{
                                progressingView(prop: prop, language: self.language, colorScheme: colorScheme)
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
                        if refreshing {
                            Spacer()
                            progressingView(prop: prop, language: self.language, colorScheme: colorScheme)
                            Spacer()
                        }
                        else{
                            
                            ZStack{
                                ScrollRefreshable(langauge: self.language, title: "កំពុងភ្ជាប់", tintColor: .blue){
                                    mainView()
                                        .padding(.bottom, prop.isiPhoneS ? 65 : prop.isiPhoneM ? 75 : prop.isiPhoneL ? 85 : 100)
                                        .padding(.horizontal, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                                        .navigationBarTitleDisplayMode(.inline)
                                        .toolbar {
                                            ToolbarItem(placement: .navigationBarLeading) {
                                                HStack{
                                                    Image(systemName: "line.3.horizontal.decrease")
                                                        .padding(.bottom, prop.isiPhoneS ? 3 : prop.isiPhoneM ? 4 : prop.isiPhoneL ? 5 : 5)
                                                    Text(barTitle.localizedLanguage(language: language))
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
                                .refreshable {
                                    do {
                                        AnnoucementList.clearCache()
                                        try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
                                    } catch {}
                                    self.hidingDivider = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        self.hidingDivider = false
                                    }
                                    refreshingView()
                                    AnnoucementList.getAnnoucement()
                                    academiclist.populateAllContinent(academicYearId: academiclist.academicYearId.isEmpty ? "62f079626cf8a36847d31d2d" : academiclist.academicYearId)
                                    students.StundentAmount(parentId: parentId)
                                }
                                if onAppearImg{
                                    ZStack{
                                        Color(colorScheme == .dark ? "Black" : "BG")
                                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                                            .ignoresSafeArea()
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
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 6){
                                                        self.currentProgress = 1000
                                                    }
                                                }
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                }
                .setBG(colorScheme: colorScheme)
                .onAppear{
                    UIApplication.shared.applicationIconBadgeNumber = 0
                    AnnoucementList.getAnnoucement()
                    academiclist.populateAllContinent(academicYearId: activeYear)
                    students.StundentAmount(parentId: parentId)
                    totalStu.getTotal()
                }
            }
            .padOnlyStackNavigationView()
            .phoneOnlyStackNavigationView()
        } else {
            
            NavigationView {
                
                VStack(spacing:0){
                    if students.AllStudents.isEmpty && AnnoucementList.Annouces.isEmpty && academiclist.academicYear.isEmpty {
                        ZStack{
                            if viewLoading{
                                progressingView(prop: prop, language: self.language, colorScheme: colorScheme)
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
                        if refreshing {
                            Spacer()
                            progressingView(prop: prop, language: self.language, colorScheme: colorScheme)
                            Spacer()
                        }
                        else{
                            ZStack{
                                ScrollRefreshable(langauge: self.language, title: "កំពុងភ្ជាប់", tintColor: .blue){
                                    mainView()
                                        .padding(.bottom, prop.isiPhoneS ? 65 : prop.isiPhoneM ? 75 : prop.isiPhoneL ? 85 : 100)
                                        .padding(.horizontal, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                                        .navigationBarTitleDisplayMode(.inline)
                                        .toolbar {
                                            ToolbarItem(placement: .navigationBarLeading) {
                                                HStack{
                                                    Image(systemName: "line.3.horizontal.decrease")
                                                        .padding(.bottom, prop.isiPhoneS ? 3 : prop.isiPhoneM ? 4 : prop.isiPhoneL ? 5 : 5)
                                                    Text(barTitle.localizedLanguage(language: language))
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
                                .refreshable {
                                    do {
                                        AnnoucementList.clearCache()
                                        try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
                                    } catch {}
                                    self.hidingDivider = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        self.hidingDivider = false
                                    }
                                    refreshingView()
                                    AnnoucementList.getAnnoucement()
                                    academiclist.populateAllContinent(academicYearId: academiclist.academicYearId.isEmpty ? "62f079626cf8a36847d31d2d" : academiclist.academicYearId)
                                    students.StundentAmount(parentId: parentId)
                                }
                                if onAppearImg{
                                    ZStack{
                                        Color(colorScheme == .dark ? "Black" : "BG")
                                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                                            .ignoresSafeArea()
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
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 6){
                                                        self.currentProgress = 1000
                                                    }
                                                }
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .setBG(colorScheme: colorScheme)
                .onAppear{
                    UIApplication.shared.applicationIconBadgeNumber = 0
                    AnnoucementList.getAnnoucement()
                    academiclist.populateAllContinent(academicYearId: activeYear)
                    students.StundentAmount(parentId: parentId)
                    totalStu.getTotal()
                }
            }
            .padOnlyStackNavigationView()
            .phoneOnlyStackNavigationView()
        }
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
                    self.bindingLanguage = "km-KH"
                } label: {
                    Text("ភាសាខ្មែរ")
                    Image("km")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                Button {
                    // Step #3
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
    
    private func mainView()-> some View{
        VStack(alignment: .leading,spacing: 0 ){
            
            //            MarqueeText(
            //                text: "Our Vision to educate Cambodian future generations to become international human resources.".localizedLanguage(language: self.language),
            //                 font: UIFont(name: "Bayon", size:  prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16)!,
            //                 leftFade: 16,
            //                 rightFade: 16,
            //                 startDelay: 1
            //                 )
            //                .foregroundColor(.pink)
            //                .padding(.top)
            
            Text("បុត្រធីតា".localizedLanguage(language: self.language))
                .foregroundColor(.blue)
                .font(.custom("Bayon", size: prop.isiPhoneS ? 20 : prop.isiPhoneM ? 22 : prop.isiPhoneL ? 24:26, relativeTo: .largeTitle))
                .hLeading()
                .padding([.top, .horizontal])
                .background(.clear)
            
            ZStack{
                imageStuBG(prop: prop)
                if students.AllStudents.isEmpty {
                    Text("មិនមានកូន".localizedLanguage(language: self.language))
                        .foregroundColor(.blue)
                } else {
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: prop.isiPhoneS ? 8 : prop.isiPhoneM ? 10 : prop.isiPhoneL ? 12 : 14){
                            ForEach(students.AllStudents,id: \.Id) { student in
                                NavigationLink(
                                    destination: Grade(studentId: student.Id, userProfileImg: userProfileImg, showTeacherImage: $showTeacherImage,UrlImg: $UrlImg, Student: "\(student.Lastname) \(student.Firstname)", StudentEnglishName: student.EnglishName, parentId: parentId, barTitle: barTitle,studentID: student.Id, language: self.language, prop: prop),
                                    label: {
                                        widgetStu(ImageStudent: student.profileImage, Firstname: student.Firstname, Lastname: student.Lastname, prop: prop, Englishname: student.EnglishName)
                                    }
                                )
                            }
                        }
                        .frame(width: (prop.isLandscape && (prop.isiPhone || prop.isiPad)) || prop.isiPad ? prop.size.width : .infinity)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical)
            Divider()
            HStack(spacing: prop.isiPhoneS ? 2 : prop.isiPhoneM ? 3 : 5){
                Image(systemName: "bell.fill")
                    .font(.system(size:prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 : 20))
                    .foregroundColor(.blue)
                Text("ព្រឹត្តិការណ៍នាពេលខាងមុខ".localizedLanguage(language: self.language))
                    .textCase(.lowercase)
                    .font(.custom("Bayon", size:prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : prop.isiPhoneL ? 20 : 22, relativeTo: .largeTitle))
                    .foregroundColor(.blue)
            }
            .padding(.vertical, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
            .hLeading()
            VStack(spacing:prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16 ){
                if academiclist.removeExpireDate.isEmpty {
                    VStack{
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .progressViewStyle(.circular)
                        Text("សូមរង់ចាំ".localizedLanguage(language: self.language))
                            .foregroundColor(.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    ForEach(Array(academiclist.removeExpireDate.prefix(3).enumerated()), id: \.element.code){ index,academic in
                        HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                            graduatedLogo(colorScheme: colorScheme)
                            VStack(alignment: .leading){
                                datingEditer(inputCode: academic.date, inputAnotherDate: academic.enddate)
                                    .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16, relativeTo: .body))
                                    .listRowBackground(Color.yellow)
                                Text(language == "en" ? academic.eventname : academic.eventnameKhmer)
                                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 11 : prop.isiPhoneM ? 13 : 15, relativeTo: .body))
                                    .listRowBackground(Color.yellow)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                        .foregroundColor(index % 2 == 0 ?  Color("bodyOrange") : Color("bodyBlue"))
                        .setBackgroundRow( color: colorScheme == .dark ? "Black" : index % 2 == 0 ?  colorOrg : colorBlue, prop: prop)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.orange, lineWidth: colorScheme == .dark ? 1 : 0)
                        )
                    }
                }
            }
            HStack(spacing: prop.isiPhoneS ? 2 : prop.isiPhoneM ? 3 : 5){
                Image(systemName: "megaphone.fill")
                    .font(.system(size:prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : 18))
                    .foregroundColor(Color("News"))
                Text("ដំណឹងថ្មីៗ".localizedLanguage(language: self.language))
                    .font(.custom("Bayon", size:prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : prop.isiPhoneL ? 20 : 22, relativeTo: .largeTitle))
                    .foregroundColor(Color("News"))
            }
            .padding(.vertical, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
            .hLeading()
            
            if !(prop.isLandscape || prop.isiPad){
                VStack(spacing: prop.isiPhoneS ? 15 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 17 : 18 ){
                    ForEach(AnnoucementList.Annouces, id: \.id) { item in
                        AnnouceButtonView(showingSheet: $showingSheet, detailId: $detailId, onAppearImg: $onAppearImg, itemImg: item.img, itemTitle: item.title, itemId: item.id, prop: prop, students: students, language: self.language)
                            .buttonStyle(PlainButtonStyle())
                            .sheet(isPresented: $showingSheet) {
                                Annoucements(prop: prop, postId: $detailId, language: self.language)
                            }
                    }
                }
            }
            ZStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: prop.isiPhoneS ? 20 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16){
                        ForEach(AnnoucementList.Annouces, id: \.id) { item in
                            
                            if reloadingAnn{
                                VStack{
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                        .progressViewStyle(.circular)
                                    Text("សូមរង់ចាំ".localizedLanguage(language: self.language))
                                        .foregroundColor(.blue)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .onAppear{
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.reloadingAnn = false
                                    }
                                }
                            } else {
                                Button {
                                    self.showingSheet.toggle()
                                    detailId = item.id
                                } label: {
                                    
                                    AsyncImage(url: URL(string: item.img ), scale: 2){image in
                                        
                                        switch  image {
                                            
                                        case .empty:
                                            VStack{
                                                ProgressView()
                                                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                                    .progressViewStyle(.circular)
                                                Text("សូមរងចាំ".localizedLanguage(language: self.language))
                                                    .foregroundColor(.blue)
                                            }
                                        case .success(let image):
                                            ZStack(alignment: .bottomLeading) {
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                    .cornerRadius(20)
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                    .overlay(
                                                        getGradientOverlay()
                                                            .cornerRadius(20)
                                                    )
                                            }
                                            
                                            .overlay(
                                                Text(item.title)
                                                    .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                                                    .foregroundColor(.blue)
                                                    .multilineTextAlignment(.leading)
                                                    .padding()
                                                , alignment: .bottomLeading
                                                
                                            )
                                            
                                        case .failure:
                                            Text("មិនរកដំណឹងថ្មីៗបាន".localizedLanguage(language: self.language))
                                                .font(.custom("Bayon", size:prop.isiPhoneS ? 18 : prop.isiPhoneM ? 20 : prop.isiPhoneL ? 22 : 26, relativeTo: .largeTitle))
                                                .foregroundColor(.pink)
                                                .onAppear{
                                                    if !item.img.isEmpty{
                                                        self.reloadingAnn = true
                                                    }
                                                }
                                        @unknown default:
                                            fatalError()
                                        }
                                    }
                                    
                                }
                                .sheet(isPresented: $showingSheet) {
                                    Annoucements(prop: prop, postId: $detailId, language: self.language)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity,maxHeight: prop.isLandscape && prop.isiPhone ? 250 : prop.isiPad ? 300 :  250 )
                }
                if !(prop.isLandscape || prop.isiPad){
                    Color( colorScheme == .dark ? "Black" : "BG")
                        .frame(maxWidth: .infinity,maxHeight: prop.isLandscape && prop.isiPhone ? 250 : prop.isiPad ? 300 :  250 )
                }
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
    
    private func datingEditer(inputCode: String, inputAnotherDate: String) -> some View {
        language == "km-KH" ? Text(academiclist.convertDateFormater(inputDate: inputCode,inputAnotherDate: inputAnotherDate)) : Text(academiclist.convertDateFormaterForEnglish(inputDate: inputCode, inputAnotherDate: inputAnotherDate))
    }
    
    private func widgetStu(ImageStudent: String, Firstname: String, Lastname: String,prop:Properties, Englishname: String) -> some View {
        
        VStack(alignment: .center, spacing: 0){
            
            if reloadingImg {
                VStack{
                    VStack{
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .progressViewStyle(.circular)
                        Text("សូមរង់ចាំ".localizedLanguage(language: self.language))
                            .foregroundColor(.blue)
                    }
                    .frame(height: prop.isiPhoneS ? 140 : prop.isiPhoneM ? 150 : prop.isiPhoneL ? 170 : 180)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.reloadingImg = false
                        }
                    }
                }
                .frame(height: prop.isiPhoneS ? 140 : prop.isiPhoneM ? 150 : prop.isiPhoneL ? 170 : 180,alignment: .center)
                
            } else {
                AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(ImageStudent)"), scale: 2){image in
                    switch  image {
                    case .empty:
                        VStack{
                            ActivityIndicatorView(isVisible: .constant(true), type: .rotatingDots(count: 5))
                                 .frame(width: 50.0, height: 50.0)
                                 .foregroundColor(.blue)
                            Text("សូមរង់ចាំ".localizedLanguage(language: self.language))
                                .foregroundColor(.blue)
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .padding(prop.isiPhoneS ? 20 : prop.isiPhoneM ? 20 : prop.isiPhoneL ? 24 : 25)
                            .shadow(color: .gray, radius: 1, x: 0, y: 0)
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
            
            HStack{ language == "en" ? Text(Englishname) : Text("\(Lastname) \(Firstname)") }
                .padding(5)
                .padding(.horizontal, 5)
                .font(.custom("kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16, relativeTo: .largeTitle))
                .background(colorScheme == .dark ? .clear : .blue)
                .cornerRadius(5)
                .padding(.bottom, 10)
        }
        .background(.clear)
        .foregroundColor(.white)
        .frame(width: prop.isiPhoneS ? 160 : prop.isiPhoneM ? 170 : prop.isiPhoneL ? 180 : 200, height: prop.isiPhoneS ? 185 : prop.isiPhoneM ? 200 : prop.isiPhoneL ? 220 : 220, alignment: .center)
        .addBorder(.orange,width: 1, cornerRadius: 20)
    }
}
struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Dashboard(userProfileImg: "", isLoading: .constant(false), bindingLanguage: .constant(""),showTeacherImage: .constant(false),UrlImg: .constant(""), parentId: "",activeYear: "", prop: prop, mobileUserId: "", language: "em")
    }
}
struct AnnouceButtonView: View{
    @Binding var showingSheet: Bool
    @Binding var detailId: String
    @Binding var onAppearImg: Bool
    @State private var reloadingAnn: Bool = false
    var itemImg: String
    var itemTitle: String
    var itemId: String
    var prop: Properties
    var students: ListStudentViewModel
    var language: String
    var body: some View{
        Button {
            self.showingSheet.toggle()
            detailId = itemId
        } label: {
            if reloadingAnn{
                VStack{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .progressViewStyle(.circular)
                    Text("សូមរង់ចាំ".localizedLanguage(language: self.language))
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        self.reloadingAnn = false
                    }
                }
            } else {
                AsyncImage(url: URL(string: itemImg ), scale: 1){image in
                    switch  image {
                        
                    case .empty:
                        VStack{
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .progressViewStyle(.circular)
                            Text("សូមរង់ចាំ".localizedLanguage(language: self.language))
                                .foregroundColor(.blue)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    case .success(let image):
                        ZStack(alignment:.bottom){
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity,maxHeight: .infinity)
                                .cornerRadius(30)
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: prop.isiPhoneS ? 80 : prop.isiPhoneM ? 90 : prop.isiPhoneL ? 150 : 120)
                                .foregroundColor(.clear)
                                .overlay(
                                    getGradientOverlay()
                                        .cornerRadius(30)
                                )
                            HStack(spacing: 0){
                                Text(itemTitle)
                                    .font(.custom("Bayon", size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : 18, relativeTo: .body))
                                    .foregroundColor(.blue)
                                    .padding()
                                    .frame(maxWidth:.infinity, alignment: .leading)
                                
                            }
                        }
                        .onAppear{
                            if students.AllStudents.isEmpty{
                                self.onAppearImg = false
                            }
                        }
                    case .failure:
                        Text("មិនអាចទាញទិន្ន័យបាន".localizedLanguage(language: self.language))
                            .font(.custom("Bayon", size:prop.isiPhoneS ? 18 : prop.isiPhoneM ? 20 : prop.isiPhoneL ? 22 : 26, relativeTo: .largeTitle))
                            .foregroundColor(.pink)
                            .onAppear{
                                if students.AllStudents.isEmpty{
                                    self.onAppearImg = false
                                }
                                if !itemImg.isEmpty{
                                    self.reloadingAnn = true
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
