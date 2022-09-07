//
//  Dashboard.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI
import ACarousel
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
    @State var imgLoading: Bool = false
    @State var tooltipVisible: Bool = false
    @State var refreshing: Bool = false
    @Binding var isLoading: Bool
    let gradient = Color.clear
    var barTitle: String = "ទំព័រដើម"
    var parentId: String
    var prop: Properties
    var body: some View {
        NavigationView {
            VStack(spacing:0){
                if students.AllStudents.isEmpty || academiclist.academicYear.isEmpty{
                    progressingView(prop: prop)
                }else if students.Error{
                    Text("ព្យាយាមម្តងទៀត")
                        .foregroundColor(.blue)
                }else{
                    Divider()
                    if refreshing {
                        Spacer()
                        progressingView(prop: prop)
                        Spacer()
                    }else{
                        ScrollRefreshable(title: "កំពុងភ្ជាប់", tintColor: .blue){
                            VStack{
                               mainView()
                            }
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbarView(prop: prop, barTitle: barTitle, profileImg: userProfileImg)
                            .padding()
                            .padding(.bottom,45)
                        }
                    }
                }
            }
            .setBG()
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: false)) {
                    AnnoucementList.getAnnoucement()
                    academiclist.populateAllContinent()
                    students.StundentAmount(parentId: parentId)
                }
            }
        }
        .refreshable {
            do {
                // Sleep for 2 seconds
                try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            } catch {}
            refreshingView()
            AnnoucementList.getAnnoucement()
            academiclist.populateAllContinent()
            students.StundentAmount(parentId: parentId)
        }
        .padOnlyStackNavigationView()
        .phoneOnlyStackNavigationView()
    }
    private func mainView()-> some View{
        ScrollView(.vertical, showsIndicators: false){
            ZStack{
                imageStuBG(width: prop.isiPhoneS ? 200 : prop.isiPhoneM ? 220: prop.isiPhoneL ? 260 : 280)
                VStack(spacing: 0){
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: prop.isiPhoneS ? 8 : prop.isiPhoneM ? 10 : 12){
                            ForEach(students.AllStudents,id: \.Id) { student in
                                NavigationLink(
                                    destination: Grade(studentId: student.Id, userProfileImg: userProfileImg, Enrollment: student.Enrollments, Student: "\(student.Lastname) \(student.Firstname)", parentId: parentId, barTitle: barTitle,prop: prop),
                                    label: {
                                        widgetStu(ImageStudent: student.profileImage, Firstname: student.Firstname, Lastname: student.Lastname, prop: prop)
                                    }
                                )
                            }
                        }
                    }
                    .padding(.bottom,prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14)
                    Divider()
                }
            }
            HStack(spacing: prop.isiPhoneS ? 2 : prop.isiPhoneM ? 3 : 5){
                Image(systemName: "bell.fill")
                    .font(.system(size:prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20))
                    .foregroundColor(.blue)
                    .padding(.bottom, 5)
                Text("ព្រឺត្តិការណ៍នាពេលខាងមុខ")
                    .font(.custom("Bayon", size:prop.isiPhoneS ? 18 : prop.isiPhoneM ? 20 : prop.isiPhoneL ? 22 : 26, relativeTo: .largeTitle))
                    .foregroundColor(.blue)
            }
            .padding(.vertical,prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14)
            .hLeading()
            VStack(spacing:prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14){
                ForEach(Array(academiclist.academicYear.enumerated()), id: \.element.code){ index,academic in
                    if academiclist.isCurrentEvents(date: academic.date) {
                        HStack(spacing: 20){
                            graduatedLogo()
                            VStack(alignment: .leading){
                                datingEditer(inputCode: academic.date)
                                    .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16, relativeTo: .body))
                                    .listRowBackground(Color.yellow)
                                Text(academic.eventnameKhmer)
                                    .font(.custom("Kantumruy", size: 15, relativeTo: .body))
                                    .listRowBackground(Color.yellow)
                            }
                        }
                        .foregroundColor(index % 2 == 0 ?  Color("bodyOrange") : Color("bodyBlue"))
                        .setBackgroundRow(color: index % 2 == 0 ?  colorOrg : colorBlue)
                        .frame(height: prop.isLandscape ? 80 : .infinity)
                    }
                }
            }
            HStack(spacing: prop.isiPhoneS ? 2 : prop.isiPhoneM ? 3 : 5){
                Image(systemName: "megaphone.fill")
                    .font(.system(size:prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20))
                    .foregroundColor(.pink)
                    .padding(.bottom, 5)
                Text("ដំណឹងថ្មីៗ")
                    .font(.custom("Bayon", size:prop.isiPhoneS ? 18 : prop.isiPhoneM ? 20 : prop.isiPhoneL ? 22 : 26, relativeTo: .largeTitle))
                    .foregroundColor(.pink)
            }
            .padding(.vertical,prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14)
            .hLeading()
            
            if prop.isLandscape {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20){
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
                                                .cornerRadius(30)
                                        case .failure:
                                            Text("Not Found News")
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
                                    VStack(spacing: 0){
                                        Text(item.title)
                                            .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16, relativeTo: .body))
                                            .foregroundColor(.blue)
                                            .padding()
                                            .shadow(color: .white, radius: 5)
                                            .frame(maxWidth:.infinity, alignment: .leading)
                                    }
                                }
                                .frame(maxHeight: prop.isLandscape ? 250 : 250 )
                            }
                            .sheet(isPresented: $showingSheet) {
                                Annoucements(prop: prop, postId: $detailId)
                            }
                        }
                    }
                }
            }else{
                VStack{
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshing = false
        }
    }
    func datingEditer(inputCode: String) -> some View {
        Text(academiclist.convertDateFormat(inputDate: inputCode))
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
                        Text("សូមរងចាំ")
                            .foregroundColor(.blue)
                    }
                case .success(let image):
                    image
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
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
            .frame(height:  prop.isiPhoneS ? 130 : prop.isiPhoneM ? 150 : prop.isiPhoneL ? 170 : 180)
            
            HStack{
                Text(Lastname)
                Text(Firstname)
            }
            .padding(5)
            .font(.system(size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 :16))
            .frame(maxWidth: prop.isiPhoneS ? 100 : prop.isiPhoneM ? 110 : prop.isiPhoneL ? 120 : 130)
            .background(.blue)
            .cornerRadius(5)
            .padding(.bottom, 10)
        }
        .background(.clear)
        .foregroundColor(.white)
        .frame(width: prop.isiPhoneS ? 140 : prop.isiPhoneM ? 160 : prop.isiPhoneL ? 180 : 200, height: prop.isiPhoneS ? 165 : prop.isiPhoneM ? 185 : prop.isiPhoneL ? 220 : 220, alignment: .center)
        .addBorder(.orange,width: 1, cornerRadius: 20)
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Dashboard(userProfileImg: "", isLoading: .constant(false), parentId: "",prop: prop)
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
                            Text("សូមរងចាំ")
                                .foregroundColor(.blue)
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxHeight: .infinity)
                            .cornerRadius(30)
                    case .failure:
                        Text("Not Found News")
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
                VStack(spacing: 0){
                    Text(itemTitle)
                        .font(.custom("Bayon", size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : 18, relativeTo: .body))
                        .foregroundColor(.blue)
                        .padding()
                        .shadow(color: .white, radius: 5)
                        .frame(maxWidth:.infinity, alignment: .leading)
                }
            }
        }
        
    }
}

