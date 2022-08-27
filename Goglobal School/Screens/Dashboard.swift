//
//  Dashboard.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI
import ACarousel

struct Dashboard: View {
    @StateObject var students: ListStudentViewModel = ListStudentViewModel()
    @StateObject var academiclist: ListViewModel = ListViewModel()
    @StateObject var AnnoucementList: AnnouncementViewModel = AnnouncementViewModel()
    @State var colorBlue: String = "LightBlue"
    @State var colorOrg: String = "LightOrange"
    @State var ImageStudent: String = ""
    @State var NameStudent: String = ""
    @State var showingSheet: Bool = false
    @State var detailId: String =  ""
    @State var imgLoading: Bool = false
    @Binding var isLoading: Bool
    let gradient = Color.clear
    var barTitle: String = "ទំព័រដើម"
    var parentId: String
    var prop: Properties
    var body: some View {
        NavigationView {
            ZStack{
                if students.AllStudents.isEmpty || academiclist.academicYear.isEmpty{
                    progressingView(prop: prop)
                }else{
                    VStack(spacing:0){
                        Divider()
                        ScrollView(.vertical, showsIndicators: false) {
                            ZStack{
                                imageStuBG(width: prop.isiPhoneS ? 200 : prop.isiPhoneM ? 220: prop.isiPhoneL ? 260 : 280)
                                VStack(spacing: 0){
                                    ScrollView(.horizontal, showsIndicators: false){
                                        HStack(spacing: prop.isiPhoneS ? 8 : prop.isiPhoneM ? 10 : 12){
                                            ForEach(students.AllStudents,id: \.Id) { student in
                                                NavigationLink(
                                                    destination: Grade(Enrollment: student.Enrollments, parentId: parentId, barTitle: barTitle,prop: prop, Student: "\(student.Lastname) \(student.Firstname)"),
                                                    label: {
                                                        widgetStu(ImageStudent: student.profileImage, Firstname: student.Firstname, Lastname: student.Lastname, prop: prop)
                                                    }
                                                )
                                            }
                                        }
                                    }
                                    .padding(prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14)
                                    Divider()
                                }
                            }
                            HStack{
                                Image(systemName: "bell.fill")
                                    .font(.system(size:prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20))
                                    .foregroundColor(.blue)
                                    .padding(.bottom, 5)
                                Text("ព្រឺត្តិការណ៍នាពេលខាងមុខ")
                                    .font(.custom("Bayon", size:prop.isiPhoneS ? 18 : prop.isiPhoneM ? 20 : prop.isiPhoneL ? 22 : 26, relativeTo: .largeTitle))
                                    .foregroundColor(.blue)
                            }
                            .padding(.horizontal)
                            .hLeading()
                            VStack(spacing:prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14){
                                ForEach(Array(academiclist.academicYear.enumerated()), id: \.element.code){ index,academic in
                                    if academiclist.isCurrentEvents(date: academic.date) {
                                        HStack(spacing: 20){
                                            graduatedLogo()
                                            VStack(alignment: .leading){
                                                datingEditer(inputCode: academic.date)
                                                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16, relativeTo: .body))
                                                    .listRowBackground(Color.yellow)
                                                Text(academic.eventnameKhmer)
                                                    .font(.custom("Bayon", size: 15, relativeTo: .body))
                                                    .listRowBackground(Color.yellow)
                                            }
                                        }
                                        .foregroundColor(index % 2 == 0 ?  Color("bodyOrange") : Color("bodyBlue"))
                                        .setBackgroundRow(color: index % 2 == 0 ?  colorOrg : colorBlue)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .hLeading()
                            VStack(spacing: prop.isLandscape ? 5 : 0){
                                HStack(spacing: prop.isiPhoneS ? 2 : prop.isiPhoneM ? 3 : 5){
                                    Image(systemName: "mic.fill")
                                        .font(.system(size:20))
                                        .foregroundColor(.pink)
                                        .padding(.bottom, 5)
                                    Text("ដំណឹងថ្មីៗ")
                                        .font(.custom("Bayon", size:prop.isiPhoneS ? 18 : prop.isiPhoneM ? 20 : prop.isiPhoneL ? 22 : 26, relativeTo: .largeTitle))
                                        .foregroundColor(.pink)
                                }
                                .padding(.horizontal)
                                .hLeading()
                                VStack{
                                    if AnnoucementList.Annouces.isEmpty {
                                        progressingView(prop: prop)
                                    }else{
                                        ACarousel(AnnoucementList.Annouces, id: \.id,autoScroll: .active(5)) { item in

                                                ZStack{
                                                    AsyncImage(url: URL(string: item.img ), scale: 2){image in
                                                       
                                                        switch  image {
                                                            
                                                        case .empty:
                                                            ProgressView()
                                                                .progressViewStyle(.circular)
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
                                                    VStack(spacing: 0){
                                                        HStack{
                                                            Text(item.title)
                                                                .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16, relativeTo: .body))
                                                                .foregroundColor(.blue)
                                                                .padding(.horizontal)
                                                                .shadow(color: .white, radius: 5)
                                                                .frame(maxWidth:.infinity, alignment: .leading)
                                                            Spacer()
                                                            Button {
                                                                self.showingSheet.toggle()
                                                                    detailId = item.id
                                                            } label: {
                                                            Text("see more>>>")
                                                                .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16, relativeTo: .body))
                                                                .foregroundColor(.blue)
                                                                .shadow(color: .white, radius: 5)
                                                                .padding(.horizontal)
                                                            }
                                                            .sheet(isPresented: $showingSheet) {
                                                                Annoucements(prop: prop, postId: $detailId)
                                                            }
                                                        }
                                                        .frame(maxWidth: .infinity)
                                                        
                                                        Text(item.description)
                                                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                                                            .foregroundColor(.blue)
                                                            .padding(.horizontal)
                                                            .shadow(color: .white, radius: 5)
                                                            .frame(maxWidth:.infinity, alignment: .leading)
                                                    }
                                                    .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .bottom)
                                                }
                                        }
                                        .frame(width: prop.isLandscape ? 400 : .infinity, height: prop.isiPad ? 500 : prop.isiPhoneS && prop.isLandscape ? 250 : prop.isiPhoneS ? 230 : prop.isiPhoneM && prop.isLandscape ?  260 : prop.isiPhoneM ? 240  : prop.isiPhoneL  ? 280 : 500)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.bottom,60)
                            }
                        }
                        
                    }
                    .setBG()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarView(prop: prop, barTitle: barTitle)
                    if imgLoading{
                    ZStack{
                        Color("BG")
                            .ignoresSafeArea()
                        progressingView(prop: prop)
                        }
                    }
                }
                
            }
            .onAppear {
                AnnoucementList.getAnnoucement()
                academiclist.populateAllContinent()
                students.StundentAmount(parentId: parentId)
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
        .padOnlyStackNavigationView()
        .phoneOnlyStackNavigationView()
    }
    func datingEditer(inputCode: String) -> some View {
        Text(academiclist.convertDateFormat(inputDate: inputCode))
    }
    func widgetStu(ImageStudent: String, Firstname: String, Lastname: String,prop:Properties) -> some View {
        
        VStack(alignment: .center, spacing: 0){
            AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(ImageStudent)"), scale: 2){image in
                
                switch  image {
                case .empty:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .onAppear {
                            self.imgLoading = true
                        }
                case .success(let image):
                    image
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
                        .onAppear {
                            self.imgLoading = false
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
        .frame(width: prop.isiPhoneS ? 140 : prop.isiPhoneM ? 160 : prop.isiPhoneL ? 180 : 200, height: prop.isiPhoneS ? 160 : prop.isiPhoneM ? 180 : prop.isiPhoneL ? 220 : 220, alignment: .center)
        .addBorder(.orange,width: 1, cornerRadius: 20)
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Dashboard(isLoading: .constant(false), parentId: "",prop: prop)
    }
}



