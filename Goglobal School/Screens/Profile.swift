//
//  Profile.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI
import Alamofire
import URLImage
import ImageViewer

struct Profile: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var logout: LoginViewModel
    @StateObject var uploadImg: UpdateMobileUserProfileImg
    @StateObject var userProfile: MobileUserViewModel = MobileUserViewModel()
    @StateObject var students: ListStudentViewModel = ListStudentViewModel()
    @StateObject var academiclist: ListViewModel = ListViewModel()
    @StateObject var AnnoucementList: AnnouncementViewModel = AnnouncementViewModel()
    @StateObject var AllClasses: ScheduleViewModel = ScheduleViewModel()
    @StateObject var Attendance: ListAttendanceViewModel = ListAttendanceViewModel()
    @State var isLoading: Bool = false
    @State var axcessPadding: CGFloat = 0
    @State var image = UIImage()
    @State var imageURL: String = ""
    @State var showSheet = false
    @State var refresh: Bool = false
    @State var refreshing: Bool = false
    @State var showImage: Bool = false
    @State var logoutLoading: Bool = false
    @State var viewLoading: Bool = false
    @State private var showingAlert = false
    @State var showImageViewer: Bool = true
    @State var showingBG: Bool = false
    @State var hidingDivider: Bool = false
    @State var imageBG = Image("BgNews")
    @Binding var Loading: Bool
    @Binding var hideTab: Bool
    @Binding var checkState: Bool
    let gradient = Color("BG")
    var prop: Properties
    var btnBack : some View { btnBackView(prop: prop, title: "គណនី").opacity(showImage || showingBG ? 0:1)}
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack(spacing: 0){
                    VStack(spacing: 0){
                        if userProfile.userID.isEmpty{
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
                        }else if userProfile.Error{
                            Text("សូមព្យាយាមម្តងទៀត")
                                .foregroundColor(.blue)
                        }else{
                            Divider()
                                .opacity(hidingDivider ? 0:1)
                            if refreshing {
                                Spacer()
                                progressingView(prop: prop)
                                Spacer()
                            }else{
                                ScrollRefreshable(title: "កំពុងភ្ជាប់", tintColor: .blue){
                                    ScrollView(.vertical, showsIndicators: false){
                                        mainView()
                                    }
                                    .navigationBarItems(leading: btnBack)
                                    .navigationBarTitleDisplayMode(.inline)
                                    .padding(.top)
                                    .padding(.horizontal, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                                    .padding(.bottom, prop.isiPhoneS ? 65 : prop.isiPhoneM ? 75 : prop.isiPhoneL ? 85 : 100)
                                }
                            }
                        }
                    }
                    .sheet(isPresented: $showSheet) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    }
                }
                ZStack{
                    if showImage{
                        Button {
                            showImage.toggle()
                            self.hideTab.toggle()
                        } label: {
                            ZStack{
                                Rectangle()
                                    .fill(.black)
                                    .opacity(0.8)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .ignoresSafeArea()
                                ShowImage()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                    }
                    if logoutLoading{
                        progressingView(prop: prop)
                    }
                    if showingBG{
                        VStack {
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .overlay(ImageViewer(image: self.$imageBG, viewerShown: self.$showingBG, closeButtonTopRight: true) .onDisappear{
                            DispatchQueue.main.async {
                                self.hideTab = false
                            }
                        })
                    }
                }
            }
            .setBG()
            .onAppear{
                userProfile.getProfileImage(mobileUserId: logout.userprofileId)
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
        .refreshable {
            do {
                userProfile.clearCache()
                // Sleep for 2 seconds
                try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            } catch {}
            self.hidingDivider = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.hidingDivider = false
            }
            refreshingView()
            userProfile.getProfileImage(mobileUserId: logout.userprofileId)
        }
        .phoneOnlyStackNavigationView()
        .padOnlyStackNavigationView()
    }
    @ViewBuilder
    private func mainView()-> some View{
        if prop.isLandscape && prop.isiPad{
            HStack(spacing: 30) {
                VStack(spacing: 0){
                    ZStack{
                        Button {
                            self.showingBG = !self.showingBG
                            DispatchQueue.main.async {
                                self.hideTab = true
                            }
                        } label: {
                            backgroundViewProfile()
                                .onDisappear{
                                    DispatchQueue.main.async {
                                        self.hideTab = false
                                    }
                                }
                        }
                        ZStack{
                            if userProfile.userID.isEmpty{
                                Image(uiImage: self.image)
                                    .resizable()
                                    .cornerRadius(50)
                                    .frame(width: 125, height: 125)
                                    .background(Color.black.opacity(0.2))
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .strokeBorder(Color.white,lineWidth: 2)
                                    )
                                    .onTapGesture {
                                        showSheet = true
                                    }
                            }else{
                                ZStack{
                                    if refresh{
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                            .frame(width: 125, height: 125, alignment: .center)
                                    }else{
                                        mainViewofProfile()
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        .sheet(isPresented: $showSheet, content: {
                            ImagePicker(selectedImage: self.$image)
                        })
                    }
                    .frame(maxWidth: .infinity, maxHeight: 240)
                    VStack(alignment: .center){
                        HStack{
                            Text(logout.userLastname)
                            Text(logout.userFirstname)
                        }
                        .font(.system(size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 : 20).bold())
                        .foregroundColor(Color.black)
                    }
                    .padding(prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                    HStack(spacing: 0){
                        rectangleBetweenButtonSave()
                        UploadingProfileImage()
                        rectangleBetweenButtonSave()
                    }
                }
                
                VStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                    ViewlistBelowProfileImg(Title: "Email Address", Description: userProfile.gmail)
                    Divider()
                    ViewlistBelowProfileImg(Title: "Contact", Description: logout.userTel)
                    Divider()
                    ViewlistBelowProfileImg(Title: "Nationality", Description: logout.userNationality)
                    Divider()
                    Button {
                        self.showingAlert = true
                    } label: {
                        Text("ចាកចេញ")
                            .font(.custom("Bayon", size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20, relativeTo: .largeTitle))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: prop.isLandscape ? 400 : .infinity, alignment: .center)
                            .padding(10)
                            .background(.red)
                            .cornerRadius(10)
                    }
                    .alert(isPresented:$showingAlert) {
                        Alert(
                            title: Text("តើអ្នកចង់ចាកចេញពីកម្មវិធីទេ?"),
                            message: Text("មិនអាចត្រលប់ក្រោយបានទេ!"),
                            primaryButton: .destructive(Text("ចាកចេញ")) {
                                self.logoutLoading = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    logout.signout()
                                    userProfile.resetMobileUser()
                                    students.resetStudent()
                                    academiclist.resetEvent()
                                    AnnoucementList.resetAnnounce()
                                    AllClasses.resetSchedule()
                                    Attendance.resetAttendance()
                                    self.logoutLoading = false
                                }
                                UserDefaults.standard.removeObject(forKey: "Gmail")
                                UserDefaults.standard.removeObject(forKey: "Password")
                                UserDefaults.standard.removeObject(forKey: "isAuthenticated")
                            },
                            secondaryButton: .cancel(Text("មិនចាកចេញ"))
                        )
                    }
                    Divider()
                }
            }
        }else{
            VStack(alignment: .leading, spacing: 0) {
                VStack(spacing: 0){
                    ZStack{
                        Button {
                            self.showingBG = !self.showingBG
                            DispatchQueue.main.async {
                                self.hideTab = true
                            }
                        } label: {
                            backgroundViewProfile()
                                .onDisappear{
                                    DispatchQueue.main.async {
                                        self.hideTab = false
                                    }
                                }
                        }
                        ZStack{
                            if userProfile.userID.isEmpty{
                                Image(uiImage: self.image)
                                    .resizable()
                                    .cornerRadius(50)
                                    .frame(width: 125, height: 125)
                                    .background(Color.black.opacity(0.2))
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .strokeBorder(Color.white,lineWidth: 2)
                                    )
                                    .onTapGesture {
                                        showSheet = true
                                    }
                            }else{
                                ZStack{
                                    if refresh{
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                            .frame(width: 125, height: 125, alignment: .center)
                                    }else{
                                        mainViewofProfile()
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        .sheet(isPresented: $showSheet, content: {
                            ImagePicker(selectedImage: self.$image)
                        })
                    }
                    .frame(maxWidth: .infinity, maxHeight: 240)
                    VStack(alignment: .center){
                        HStack{
                            Text(logout.userLastname)
                            Text(logout.userFirstname)
                        }
                        .font(.system(size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 : 20).bold())
                        .foregroundColor(Color.black)
                    }
                    .padding(prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                }
                HStack(spacing: 0){
                    rectangleBetweenButtonSave()
                    UploadingProfileImage()
                    rectangleBetweenButtonSave()
                }
                VStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                    ViewlistBelowProfileImg(Title: "Email Address", Description: userProfile.gmail)
                    Divider()
                    ViewlistBelowProfileImg(Title: "Contact", Description: logout.userTel)
                    Divider()
                    ViewlistBelowProfileImg(Title: "Nationality", Description: logout.userNationality)
                    Divider()
                    Button {
                        self.showingAlert = true
                    } label: {
                        Text("ចាកចេញ")
                            .font(.custom("Bayon", size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20, relativeTo: .largeTitle))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: prop.isLandscape ? 400 : .infinity, alignment: .center)
                            .padding(10)
                            .background(Color("redding"))
                            .cornerRadius(10)
                    }
                    .alert(isPresented:$showingAlert) {
                        Alert(
                            title: Text("តើអ្នកចង់ចាកចេញពីកម្មវិធីទេ?"),
                            primaryButton: .destructive(Text("ចាកចេញ")) {
                                self.logoutLoading = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    logout.signout()
                                    userProfile.resetMobileUser()
                                    students.resetStudent()
                                    academiclist.resetEvent()
                                    AnnoucementList.resetAnnounce()
                                    AllClasses.resetSchedule()
                                    Attendance.resetAttendance()
                                    self.logoutLoading = false
                                }
                                UserDefaults.standard.removeObject(forKey: "Gmail")
                                UserDefaults.standard.removeObject(forKey: "Password")
                                UserDefaults.standard.removeObject(forKey: "isAuthenticated")
                            },
                            secondaryButton: .cancel(Text("មិនចាកចេញ"))
                        )
                    }
                }
            }
        }
    }
    private func refreshingView(){
        self.refreshing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshing = false
        }
    }
    @ViewBuilder
    private func backgroundViewProfile()-> some View{
        VStack(spacing: 0){
            Image("BgNews")
                .resizable()
                .frame(width: prop.isiPad ? 600 : prop.isLandscape && prop.isiPhone ? 400 : .infinity)
                .cornerRadius(20)
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: prop.isLandscape ? 400 : .infinity, maxHeight: 50, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: prop.isiPad ? 450 : 200, alignment: .center)
    }
    private func mainViewofProfile()->some View{
        AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(userProfile.userProfileImg)"), scale: 2){image in
            switch  image {
            case .empty:
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(width: 125, height: 125, alignment: .center)
            case .success(let image):
                ZStack(alignment: .bottomTrailing){
                    Button {
                        self.showImage.toggle()
                        self.hideTab.toggle()
                    } label: {
                        ZStack{
                            image
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(50)
                                .frame(width: 125, height: 125, alignment: .center)
                                .clipped()
                                .background(Color.black.opacity(0.2))
                                .clipShape(Circle())
                                .padding(-5)
                            Image(uiImage: self.image)
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(50)
                                .frame(width: 125, height: 125, alignment: .center)
                                .clipped()
                                .background(.clear)
                                .clipShape(Circle())
                        }
                    }
                    
                    Image(systemName: "camera.fill")
                        .foregroundColor(.black)
                        .padding(6)
                        .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16))
                        .background(Color("LightBlue"))
                        .clipShape(Circle())
                        .onTapGesture {
                            showSheet = true
                        }
                        .offset(x: prop.isLandscape && prop.isiPhoneS ? -10 :prop.isLandscape && prop.isiPhoneM ? -6 : prop.isLandscape && prop.isiPhoneL ? -4 : prop.isLandscape  ? -5  : prop.isiPhoneS ? -8 : prop.isiPhoneM ?  -5 : prop.isiPhoneL ? -2 : 0, y: 0)
                }
                
            case .failure:
                ZStack(alignment:.bottomTrailing){
                    Button {
                        self.refresh = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.refresh = false
                        }
                    } label: {
                        ZStack{
                            Image(systemName: "person.fill")
                                .font(.system(size: 80))
                                .scaledToFill()
                                .cornerRadius(50)
                                .frame(width: 125, height: 125,alignment: .center)
                                .background(Color.white)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .padding(-5)
                                .foregroundColor(.black)
                            Image(uiImage: self.image)
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(50)
                                .frame(width: 125, height: 125, alignment: .center)
                                .clipped()
                                .background(.clear)
                                .clipShape(Circle())
                                .padding(-5)
                        }
                    }
                    Image(systemName: "camera.fill")
                        .foregroundColor(.black)
                        .padding(6)
                        .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16))
                        .background(Color("LightBlue"))
                        .clipShape(Circle())
                        .onTapGesture {
                            showSheet = true
                        }
                        .offset(x: prop.isLandscape && prop.isiPhoneS ? -10 :prop.isLandscape && prop.isiPhoneM ? -6 : prop.isLandscape && prop.isiPhoneL ? -4 : prop.isLandscape  ? -5  : prop.isiPhoneS ? -8 : prop.isiPhoneM ?  -5 : prop.isiPhoneL ? -0 : 0, y: 0)
                }
                
            @unknown default:
                fatalError()
            }
            
        }
    }
    private func rectangleBetweenButtonSave()->some View{
        Rectangle()
            .frame(width: .infinity, height: 1, alignment: .leading)
            .opacity(0.1)
    }
    private func ShowImage()-> some View{
        VStack {
            URLImage(URL(string: "https://storage.go-globalschool.com/api\(userProfile.userProfileImg)")!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .environment(\.urlImageOptions, URLImageOptions(
                maxPixelSize: CGSize(width: 600.0, height: 600.0)
            ))
        }
    }
    private func UploadingProfileImage()->some View{
        Button {
            let cgref = self.image.cgImage
            let cim = self.image.ciImage
            
            if cim == nil && cgref == nil {
                print("")
            }else{
                let name: String  = "\(logout.userId)image"
                guard let url: URL = URL(string: "https://storage.go-globalschool.com/api/school/upload") else {
                    print("invalid URL")
                    return
                }
                let boundary = generateBoundary()
                let header: HTTPHeaders = [
                    "Content-Type": "multipart/encrypted; boundary=\(boundary)"
                ]
                AF.upload(
                    multipartFormData : { multipartFormData in
                        multipartFormData.append(image.jpegData(compressionQuality: 0)!, withName: "image", fileName: "\(name).png", mimeType: "image/png")
                    }, to: url, method: .post, headers: header
                )
                .response { resp in
                    self.imageURL = "/uploads/school-Image/\(name).png"
                }
                startFakeNetworkCall()
            }
            
        } label: {
            if isLoading{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1)
                    .frame(width: 150, height: 30)
                    .background(Color("LightBlue"))
                    .cornerRadius(5)
            }else{
                Text("Save")
                    .font(.system(size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20))
                    .frame(width: 150, height: 30)
                    .background(Color("LightBlue"))
                    .cornerRadius(5)
            }
        }
    }
    private func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    private func ViewlistBelowProfileImg(Title: String,Description: String)->some View{
        HStack{
            Text(Title)
                .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14))
                .foregroundColor(.gray)
            Spacer()
            Text(Description)
                .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14))
        }
    }
    private func startFakeNetworkCall(){
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            uploadImg.uploadImg(mobileUserId: logout.userprofileId, profileImage: imageURL)
            userProfile.getProfileImage(mobileUserId: logout.userprofileId)
            isLoading = false
            self.refresh = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.refresh = false
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Profile(logout: LoginViewModel(), uploadImg: UpdateMobileUserProfileImg(), Loading: .constant(false), hideTab: .constant(false), checkState: .constant(false), prop: prop)
    }
}

