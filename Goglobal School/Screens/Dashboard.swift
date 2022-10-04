//
//  Dashboard.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI
import SwiftUITooltip

struct Dashboard: View {
    
    @StateObject var students: ListStudentViewModel = ListStudentViewModel()
    @StateObject var academiclist: ListViewModel = ListViewModel()
    @StateObject var AnnoucementList: AnnouncementViewModel = AnnouncementViewModel()
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
    @State var currentProgress: CGFloat = 250.0
    @Binding var isLoading: Bool
    let gradient = Color.clear
    var barTitle: String = "ទំព័រដើម"
    var parentId: String
    var activeYear: String
    var prop: Properties
    var body: some View {
        
        NavigationView {
            VStack(spacing:0){
                if students.AllStudents.isEmpty{
                    ZStack{
                        if viewLoading{
                            progressingView(prop: prop)
                        }else{
                            Text("មិនមានទិន្ន័យ!")
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
                    Text("សូមព្យាយាមម្តងទៀត")
                        .foregroundColor(.blue)
                }else{
                    Divider()
                        .opacity(hidingDivider ? 0:1)
                    if refreshing {
                        Spacer()
                        progressingView(prop: prop)
                        Spacer()
                    }
                    else{
                        ScrollRefreshable(title: "កំពុងភ្ជាប់", tintColor: .blue){
                            ZStack{
                                mainView()
                                    .padding(.bottom, prop.isiPhoneS ? 65 : prop.isiPhoneM ? 75 : prop.isiPhoneL ? 85 : 100)
                                    .padding(.horizontal, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                                    .navigationBarTitleDisplayMode(.inline)
                                    .toolbarView(prop: prop, barTitle: barTitle, profileImg: userProfileImg)
                                if onAppearImg{
                                    ZStack{
                                        Color("BG")
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
            }
            .setBG()
            .onAppear{
                AnnoucementList.getAnnoucement()
                academiclist.populateAllContinent(academicYearId: activeYear)
                students.StundentAmount(parentId: parentId)
            }
        }
        .padOnlyStackNavigationView()
        .phoneOnlyStackNavigationView()
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
            academiclist.populateAllContinent(academicYearId: activeYear)
            students.StundentAmount(parentId: parentId)
        }
    }
    @ViewBuilder
    private func mainView()-> some View{
        VStack(alignment: .leading,spacing: 0 ){
            ZStack{
                imageStuBG(prop: prop)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: prop.isiPhoneS ? 8 : prop.isiPhoneM ? 10 : 12){
                        ForEach(students.AllStudents,id: \.Id) { student in
                            NavigationLink(
                                destination: Grade(studentId: student.Id, userProfileImg: userProfileImg, Enrollment: student.Enrollments, Student: "\(student.Lastname) \(student.Firstname)", parentId: parentId, barTitle: barTitle,studentID: student.Id, prop: prop),
                                label: {
                                    widgetStu(ImageStudent: student.profileImage, Firstname: student.Firstname, Lastname: student.Lastname, prop: prop)
                                }
                            )
                        }
                    }
                    .frame(width: (prop.isLandscape && (prop.isiPhone || prop.isiPad)) || prop.isiPad ? prop.size.width : .infinity)
                }
            }
            Divider()
            HStack(spacing: prop.isiPhoneS ? 2 : prop.isiPhoneM ? 3 : 5){
                Image(systemName: "bell.fill")
                    .font(.system(size:prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 : 20))
                    .foregroundColor(.blue)
                Text("ព្រឹត្តិការណ៍នាពេលខាងមុខ")
                    .font(.custom("Bayon", size:prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : prop.isiPhoneL ? 20 : 22, relativeTo: .largeTitle))
                    .foregroundColor(.blue)
            }
            .padding(.vertical, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
            .hLeading()
            VStack(spacing:prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16 ){
                ForEach(Array(academiclist.removeExpireDate.prefix(3).enumerated()), id: \.element.code){ index,academic in
                    HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                       graduatedLogo()
                       VStack(alignment: .leading){
                           datingEditer(inputCode: academic.date, inputAnotherDate: academic.enddate)
                               .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16, relativeTo: .body))
                               .listRowBackground(Color.yellow)
                           Text(academic.eventnameKhmer)
                               .font(.custom("Kantumruy", size: prop.isiPhoneS ? 11 : prop.isiPhoneM ? 13 : 15, relativeTo: .body))
                               .listRowBackground(Color.yellow)
                               .fixedSize(horizontal: false, vertical: true)
                       }
                   }
                   .foregroundColor(index % 2 == 0 ?  Color("bodyOrange") : Color("bodyBlue"))
                   .setBackgroundRow(color: index % 2 == 0 ?  colorOrg : colorBlue, prop: prop)
                }
            }
            HStack(spacing: prop.isiPhoneS ? 2 : prop.isiPhoneM ? 3 : 5){
                Image(systemName: "megaphone.fill")
                    .font(.system(size:prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : 18))
                    .foregroundColor(Color("News"))
//                    .padding(.bottom, 5)
                Text("ដំណឹងថ្មីៗ")
                    .font(.custom("Bayon", size:prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : prop.isiPhoneL ? 20 : 22, relativeTo: .largeTitle))
                    .foregroundColor(Color("News"))
            }
            .padding(.vertical, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
            .hLeading()
            if prop.isLandscape || prop.isiPad{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: prop.isiPhoneS ? 20 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16){
                        ForEach(AnnoucementList.Annouces, id: \.id) { item in
                            Button {
                                self.showingSheet.toggle()
                                detailId = item.id
                            } label: {
                                ZStack(alignment:.bottom){
                                    AsyncImage(url: URL(string: item.img ), scale: 2){image in
                                        
                                        switch  image {
                                            
                                        case .empty:
                                            VStack{
                                                ProgressView()
                                                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                                    .progressViewStyle(.circular)
                                                Text("សូមរងចាំ")
                                                    .foregroundColor(.blue)
                                            }
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(maxHeight: .infinity)
                                                .cornerRadius(20)
                                                .onAppear{
                                                    self.onAppearImg = false
                                                }
                                        case .failure:
                                            Text("Not Found News")
                                                .font(.custom("Bayon", size:prop.isiPhoneS ? 18 : prop.isiPhoneM ? 20 : prop.isiPhoneL ? 22 : 26, relativeTo: .largeTitle))
                                                .foregroundColor(.pink)
                                                .onAppear{
                                                    self.onAppearImg = false
                                                }
                                        @unknown default:
                                            fatalError()
                                        }
                                    }
                                    Rectangle()
                                        .frame(maxWidth: .infinity, maxHeight: prop.isiPhoneS ? 80 : prop.isiPhoneM ? 90 : prop.isiPhoneL ? 150 : 120)
                                        .foregroundColor(.clear)
                                        .overlay(
                                            getGradientOverlay()
                                                .cornerRadius(20)
                                        )
                                    VStack(spacing: 0){
                                        Text(item.title)
                                            .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16, relativeTo: .body))
                                            .foregroundColor(.blue)
                                            .padding()
                                            .frame(maxWidth:.infinity, alignment: .leading)
                                    }
                                }
                                .frame(maxHeight: prop.isLandscape && prop.isiPhone ? 250 : prop.isiPad ? 300 :  250 )
                            }
                            .sheet(isPresented: $showingSheet) {
                                Annoucements(prop: prop, postId: $detailId)
                            }
                        }
                    }
                }
            }else{
                VStack(spacing: prop.isiPhoneS ? 15 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 17 : 18 ){
                    ForEach(AnnoucementList.Annouces, id: \.id) { item in
                        AnnouceButtonView(showingSheet: $showingSheet, detailId: $detailId, itemImg: item.img, itemTitle: item.title, itemId: item.id, prop: prop)
                            .buttonStyle(PlainButtonStyle())
                            .sheet(isPresented: $showingSheet) {
                                Annoucements(prop: prop, postId: $detailId)
                            }
                    }
                }
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
    func datingEditer(inputCode: String, inputAnotherDate: String) -> some View {
        Text(academiclist.convertDateFormater(inputDate: inputCode,inputAnotherDate: inputAnotherDate))
    }
    func widgetStu(ImageStudent: String, Firstname: String, Lastname: String,prop:Properties) -> some View {
        
        VStack(alignment: .center, spacing: 0){
            AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(ImageStudent)"), scale: 2){image in
                switch  image {
                case .empty:
                    VStack{
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .progressViewStyle(.circular)
                        Text("សូមរង់ចាំ")
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
                @unknown default:
                    fatalError()
                }
            }
            .frame(height: prop.isiPhoneS ? 140 : prop.isiPhoneM ? 150 : prop.isiPhoneL ? 170 : 180)
            HStack{
                Text(Lastname)
                Text(Firstname)
            }
            .padding(2)
            .font(.custom("kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16, relativeTo: .largeTitle))
            .frame(maxWidth: prop.isiPhoneS ? 100 : prop.isiPhoneM ? 110 : prop.isiPhoneL ? 120 : 130)
            .background(.blue)
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
        Dashboard(userProfileImg: "", isLoading: .constant(false), parentId: "",activeYear: "", prop: prop)
    }
}
struct AnnouceButtonView: View{
    @Binding var showingSheet: Bool
    @Binding var detailId: String
    var itemImg: String
    var itemTitle: String
    var itemId: String
    var prop: Properties
    var body: some View{
        Button {
            self.showingSheet.toggle()
            detailId = itemId
        } label: {
            ZStack(alignment:.bottom){
                AsyncImage(url: URL(string: itemImg ), scale: 2){image in
                    switch  image {
                        
                    case .empty:
                        VStack{
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .progressViewStyle(.circular)
                            Text("សូមរង់ចាំ")
                                .foregroundColor(.blue)
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxHeight: .infinity)
                            .cornerRadius(30)
                    case .failure:
                        Text("មិនអាចទាញទិន្ន័យបាន")
                            .font(.custom("Bayon", size:prop.isiPhoneS ? 18 : prop.isiPhoneM ? 20 : prop.isiPhoneL ? 22 : 26, relativeTo: .largeTitle))
                            .foregroundColor(.pink)
                    @unknown default:
                        fatalError()
                    }
                }
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
        }
    }
}
