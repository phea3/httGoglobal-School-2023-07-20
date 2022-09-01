//
//  Profile.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI
import Alamofire
import PhotoSelectAndCrop
import URLImage

struct Profile: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.verticalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject private var loginViewModel: LoginViewModel
    @ObservedObject var logout: LoginViewModel
    @ObservedObject var uploadImg: UpdateMobileUserProfileImg
    @StateObject var userProfile: MobileUserViewModel = MobileUserViewModel()
    @State var isLoading: Bool = false
    @State var axcessPadding: CGFloat = 0
    @State private var image = UIImage()
    @State var imageURL: String = ""
    @State private var showSheet = false
    @State private var refresh: Bool = false
    @State var showImage: Bool = false
    @Binding var Loading: Bool
    @Binding var hideTab: Bool
    let gradient = Color("BG")
    var prop: Properties
    var btnBack : some View { btnBackView(prop: prop, title: "គណនី").opacity(showImage ? 0:1)}
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    VStack(spacing: 0){
                        Divider()
                        ScrollView(.vertical, showsIndicators: false){
                            VStack(spacing: 0){
                                ZStack{
                                    backgroundViewProfile()
                                    VStack{
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
                                            
                                            VStack{
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
                                VStack{
                                    Text(logout.userName)
                                        .font(.system(size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20).bold())
                                        .foregroundColor(Color.black)
                                }
                                .padding()
                            }
                            ZStack{
                                HStack(spacing: 0){
                                    rectangleBetweenButtonSave()
                                    UploadingProfileImage()
                                    rectangleBetweenButtonSave()
                                }
                                if isLoading{
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                        .scaleEffect(prop.isiPhoneS ? 2 : prop.isiPhoneM ? 2.5:3)
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
                                    logout.signout()
                                } label: {
                                    Text("LOG OUT")
                                        .font(.system(size:prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: prop.isLandscape ? 400 : .infinity, alignment: .center)
                                        .padding(10)
                                        .background(.red)
                                        .cornerRadius(10)
                                }
                                Divider()
                            }
                            .hCenter()
                        }
                        .padding()
                    }
                    .padding(.bottom,25)
                    .applyBG()
                    .navigationBarItems(leading: btnBack)
                    .navigationBarTitleDisplayMode(.inline)
                    .sheet(isPresented: $showSheet) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    }
                }
                if showImage{
                    ZStack{
                        Button {
                            showImage.toggle()
                            self.hideTab.toggle()
                        } label: {
                            Rectangle()
                                .fill(.black)
                                .opacity(0.8)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                        
                        ShowImage()
                    }
                    .background(.clear)
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
        .phoneOnlyStackNavigationView()
        .padOnlyStackNavigationView()
    }
    @ViewBuilder
    private func backgroundViewProfile()-> some View{
        VStack(spacing: 0){
            Image("BgNews")
                .resizable()
                .frame(width: prop.isLandscape && prop.isiPhone ? 400 : .infinity)
                .cornerRadius(20)
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: prop.isLandscape ? 400 : .infinity, maxHeight: 50, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: 200, alignment: .center)
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
                        .padding(4)
                        .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16))
                        .background(Color("LightBlue"))
                        .clipShape(Circle())
                        .onTapGesture {
                            showSheet = true
                        }
                }
                
            case .failure:
                ZStack(alignment:.bottomTrailing){
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
                    Image(systemName: "camera.fill")
                        .foregroundColor(.black)
                        .padding(4)
                        .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16))
                        .background(Color("LightBlue"))
                        .clipShape(Circle())
                        .onTapGesture {
                            showSheet = true
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
    private func ShowImage()-> some View{
        VStack {
            URLImage(URL(string: "https://storage.go-globalschool.com/api/uploads/school-Image/\(logout.userId)image.png")!) { image in
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
            Text("Save")
                .font(.system(size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20))
                .frame(width: 150, height: 30)
                .background(Color("LightBlue"))
                .cornerRadius(5)
        }
    }
    func generateBoundary() -> String {
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
    func startFakeNetworkCall(){
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
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Profile(logout: LoginViewModel(), uploadImg: UpdateMobileUserProfileImg(), Loading: .constant(false), hideTab: .constant(false), prop: prop)
    }
}

