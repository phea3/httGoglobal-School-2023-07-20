//
//  Profile.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI
import Alamofire
import ImageViewer
import ImageViewerRemote

struct Profile: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var logout: LoginViewModel
    @StateObject var uploadImg: UpdateMobileUserProfileImg
    @StateObject var userProfile: MobileUserViewModel = MobileUserViewModel()
    @StateObject var students: ListStudentViewModel = ListStudentViewModel()
    @StateObject var academiclist: ListViewModel = ListViewModel()
    @StateObject var AnnoucementList: AnnouncementViewModel = AnnouncementViewModel()
    @StateObject var AllClasses: ScheduleViewModel = ScheduleViewModel()
    @StateObject var Attendance: ListAttendanceViewModel = ListAttendanceViewModel()
    @StateObject var DeviceUserLogOut: MobileUserLogOutViewModel = MobileUserLogOutViewModel()
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
    @State var showingAlert = false
    @State var onAppearImg: Bool = true
    @State var showImageViewer: Bool = true
    @State var showingBG: Bool = false
    @State var hidingDivider: Bool = false
    @State var imageBG = Image("BgNews")
    @State var currentProgress: CGFloat = 0.0
    @Binding var Loading: Bool
    @Binding var hideTab: Bool
    @Binding var checkState: Bool
    @Binding var showFlag: Bool
    @Binding var bindingLanguage: String
    let gradient = Color("BG")
    var prop: Properties
    var devicetoken: String
    var language: String
    var btnBack : some View { btnBackView(language: self.language, prop: prop, title: "គណនី").opacity(showImage || showingBG ? 0:1)}
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack(spacing: 0){
                    VStack(spacing: 0){
                        if userProfile.userID.isEmpty{
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
                        }else if userProfile.Error{
                            Text("សូមព្យាយាមម្តងទៀត".localizedLanguage(language: self.language))
                                .foregroundColor(.blue)
                        }else{
                            Divider()
                                .opacity(hidingDivider ? 0:1)
                            if refreshing {
                                Spacer()
                                progressingView(prop: prop, language: self.language, colorScheme: colorScheme)
                                Spacer()
                            }else{
                                ZStack{
                                    ScrollRefreshable(langauge: self.language, title: "កំពុងភ្ជាប់", tintColor: .blue){
                                        ScrollView(.vertical, showsIndicators: false){
                                            mainView()
                                                .padding(.top)
                                                .padding(.horizontal, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                                                .padding(.bottom, prop.isiPhoneS ? 65 : prop.isiPhoneM ? 75 : prop.isiPhoneL ? 85 : 100)
                                        }
                                        .navigationBarItems(leading: btnBack)
                                        .navigationBarTitleDisplayMode(.inline)
                                        .toolbar {
                                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                                ChangeLanguage()
                                                    .opacity(showImage || showingBG ? 0:1)
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
                                
                            }
                        }
                    }
                    .sheet(isPresented: $showSheet) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    }
                }
                
                ZStack{
                    
                    if showImage{
                        VStack {
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .overlay(ImageViewerRemote(imageURL: .constant(userProfile.userProfileImg), viewerShown: self.$showImage, disableCache: true, closeButtonTopRight: true)
                            .onDisappear{
                            DispatchQueue.main.async {
                                self.hideTab = false
                            }
                        })
                    }
                    
                    if logoutLoading{
                        progressingView(prop: prop, language: self.language, colorScheme: colorScheme)
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
            .setBG(colorScheme: colorScheme)
            .onAppear{
                userProfile.getProfileImage(mobileUserId: logout.userprofileId)
                students.StundentAmount(parentId: logout.userId)
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
    @ViewBuilder
    private func mainView()-> some View{
        
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
                                    ZStack(alignment: .bottomTrailing) {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                            .frame(width: 125, height: 125, alignment: .center)
                                            .background(Circle().fill(.white))
                                            .overlay{
                                                Circle()
                                                    .stroke(.orange, lineWidth: 1)
                                            }
                                        Image(systemName: "camera.fill")
                                            .foregroundColor(.black)
                                            .padding(6)
                                            .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16))
                                            .background(.white)
                                            .clipShape(Circle())
                                            .overlay {
                                                Circle()
                                                    .stroke(.black, lineWidth: 1)
                                            }
                                    }
                                    
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
                        language == "en" ?
                        Text(logout.userName.isEmpty ? "\(logout.userLastname) \(logout.userFirstname)" : logout.userName) :
                        Text("\(logout.userLastname) \(logout.userFirstname)")
                    }
                    .font(.system(size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 : 20))
                    .foregroundColor(Color.black)
                    .padding(.horizontal)
                }
                .padding(prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
            }
            HStack(spacing: 0){
                rectangleBetweenButtonSave()
                UploadingProfileImage()
                rectangleBetweenButtonSave()
            }
            VStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                ViewlistBelowProfileImg(Title: "អ៉ីម៉ែល", Description: userProfile.gmail)
                Divider()
                ViewlistBelowProfileImg(Title: "លេខទូរស័ព្ធ", Description: logout.userTel)
                Divider()
                ViewlistBelowProfileImg(Title: "សញ្ជាតិ", Description: logout.userNationality)
                Divider()
                Button {
                    self.showingAlert = true
                } label: {
                    Text("ចាកចេញ".localizedLanguage(language: self.language))
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
                        title: Text("តើអ្នកចង់ចាកចេញពីកម្មវិធីទេ?".localizedLanguage(language: self.language)),
                        primaryButton: .destructive(Text("ចាកចេញ".localizedLanguage(language: self.language))) {
                            self.logoutLoading = true
                            DeviceUserLogOut.MobileUserLogOut(mobileUserId: logout.userprofileId, token: devicetoken)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                logout.signout()
                                showFlag = false
                                UserDefaults.standard.removeObject(forKey: "DeviceToken")
                                self.logoutLoading = false
                            }
                            UserDefaults.standard.removeObject(forKey: "Gmail")
                            UserDefaults.standard.removeObject(forKey: "Password")
                            UserDefaults.standard.removeObject(forKey: "isAuthenticated")
                        },
                        secondaryButton: .cancel(Text("មិនចាកចេញ".localizedLanguage(language: self.language)))
                    )
                }
            }
            .padding(.top,10)
        }
    }
    private func refreshingView(){
        self.refreshing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshing = false
            self.onAppearImg = true
        }
    }
    @ViewBuilder
    private func backgroundViewProfile()-> some View{
        VStack(spacing: 0){
            Image("BgNews")
                .resizable()
                .frame(width: prop.isiPad ? 600 : prop.isLandscape && prop.isiPhone ? 400 : .infinity)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.orange, lineWidth: 1)
                )
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: prop.isLandscape ? 400 : .infinity, maxHeight: 50, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: prop.isiPad ? 450 : 200, alignment: .center)
    }
    private func mainViewofProfile()->some View{
        
        AsyncImage(url: URL(string: userProfile.userProfileImg), scale: 2){image in
            switch  image {
                
            case .empty:
                if userProfile.userProfileImg.isEmpty {
                    ZStack(alignment: .bottomTrailing){
                        
                        ZStack{
                            Image(systemName: "person.fill")
                                .font(.system(size: 80))
                                .scaledToFill()
                                .frame(width: 125, height: 125,alignment: .center)
                                .background(Color.white)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .padding(-5)
                                .foregroundColor(.black)
                                .onAppear{
                                    self.onAppearImg = false
                                }
                            Image(uiImage: self.image)
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(50)
                                .frame(width: 125, height: 125, alignment: .center)
                                .clipped()
                                .background(.clear)
                                .clipShape(Circle())
                                .overlay{
                                    Circle()
                                        .stroke(.orange, lineWidth: 1)
                                }
                        }
                        
                        Image(systemName: "camera.fill")
                            .foregroundColor(.black)
                            .padding(6)
                            .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16))
                            .background(.white)
                            .clipShape(Circle())
                            .onTapGesture {
                                showSheet = true
                            }
                            .overlay {
                                Circle()
                                    .stroke(.black, lineWidth: 1)
                            }
                        
                    }
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(width: 125, height: 125, alignment: .center)
                }
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
                                .onAppear{
                                    self.onAppearImg = false
                                }
                            Image(uiImage: self.image)
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(50)
                                .frame(width: 125, height: 125, alignment: .center)
                                .clipped()
                                .background(.clear)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(.orange, lineWidth: 1)
                                }
                        }
                    }
                    
                    Image(systemName: "camera.fill")
                        .foregroundColor(.black)
                        .padding(6)
                        .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16))
                        .background(.white)
                        .clipShape(Circle())
                        .onTapGesture {
                            showSheet = true
                        }
                        .overlay {
                            Circle()
                                .stroke(.black, lineWidth: 1)
                        }
                    
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
                                .frame(width: 125, height: 125,alignment: .center)
                                .background(Color.white)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .padding(-5)
                                .foregroundColor(.black)
                                .onAppear{
                                    self.onAppearImg = false
                                }
                            Image(uiImage: self.image)
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(50)
                                .frame(width: 125, height: 125, alignment: .center)
                                .clipped()
                                .background(.clear)
                                .clipShape(Circle())
                                .overlay{
                                    Circle()
                                        .stroke(.orange, lineWidth: 1)
                                }
                        }
                    }
                    Image(systemName: "camera.fill")
                        .foregroundColor(.black)
                        .padding(6)
                        .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16))
                        .background(.white)
                        .clipShape(Circle())
                        .onTapGesture {
                            showSheet = true
                        }
                        .overlay{
                            Circle()
                                .stroke(.black, lineWidth: 1)
                        }
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
                    .background(Color(colorScheme == .dark ? "Black" : "LightBlue"))
                    .cornerRadius(5)
            }else{
                Text("រក្សាទុក".localizedLanguage(language: self.language))
                    .font(.system(size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20))
                    .frame(width: 150, height: 30)
                    .background(Color(colorScheme == .dark ? "Black" : "LightBlue"))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.orange, lineWidth: colorScheme == .dark ? 1 : 0)
                    )
            }
        }
    }
    private func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    private func ViewlistBelowProfileImg(Title: String, Description: String)->some View{
        HStack{
            Text(Title.localizedLanguage(language: self.language))
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
        Profile(logout: LoginViewModel(), uploadImg: UpdateMobileUserProfileImg(), Loading: .constant(false), hideTab: .constant(false), checkState: .constant(false), showFlag: .constant(false), bindingLanguage: .constant(""), prop: prop, devicetoken: "", language: "em")
    }
}

