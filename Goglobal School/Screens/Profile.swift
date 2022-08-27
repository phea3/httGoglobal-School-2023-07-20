//
//  Profile.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI
import Alamofire

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
    @Binding var Loading: Bool
    let gradient = Color("BG")
    var prop: Properties
    var btnBack : some View { btnBackView(prop: prop, title: "គណនី")}
    var body: some View {
        NavigationView{
            VStack{
                if userProfile.userID.isEmpty{
                    progressingView(prop: prop)
                }else{
                    VStack(spacing: 0){
                        Divider()
                        ScrollView(.vertical, showsIndicators: false){
                            VStack(spacing: 0){
                                ZStack{
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
                                                }else{
                                                    AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(userProfile.userProfileImg)"), scale: 2){image in
                                                        switch  image {
                                                        case .empty:
                                                            ProgressView()
                                                                .progressViewStyle(.circular)
                                                        case .success(let image):
                                                            ZStack{
                                                                image
                                                                    .resizable()
                                                                    .cornerRadius(50)
                                                                    .frame(width: 125, height: 125)
                                                                    .background(Color.black.opacity(0.2))
                                                                    .aspectRatio(contentMode: .fill)
                                                                    .clipShape(Circle())
                                                                Image(uiImage: self.image)
                                                                    .resizable()
                                                                    .cornerRadius(50)
                                                                    .frame(width: 125, height: 125)
                                                                    .background(.clear)
                                                                    .aspectRatio(contentMode: .fill)
                                                                    .clipShape(Circle())
                                                                    .onTapGesture {
                                                                        showSheet = true
                                                                    }
                                                            }
                                                            
                                                        case .failure:
                                                            Image(systemName: "person.fill")
                                                                .font(.system(size: 80))
                                                                .cornerRadius(50)
                                                                .frame(width: 125, height: 125)
                                                                .background(Color.white)
                                                                .aspectRatio(contentMode: .fill)
                                                                .clipShape(Circle())
                                                        @unknown default:
                                                            fatalError()
                                                        }
                                                        
                                                    }
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
                                    Text("Lok Lundy")
                                        .font(.system(size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20).bold())
                                        .foregroundColor(Color.black)
                                    
                                    Text("Occupation's position")
                                        .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14))
                                        .foregroundColor(Color.gray)
                                }
                                
                            }
                            ZStack{
                                HStack(spacing: 0){
                                    Rectangle()
                                        .frame(width: .infinity, height: 1, alignment: .leading)
                                        .opacity(0.1)
                                    
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
                                        Text("Edit")
                                            .font(.system(size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20))
                                            .frame(width: 150, height: 30)
                                            .background(Color("LightBlue"))
                                            .cornerRadius(5)
                                    }
                                    Rectangle()
                                        .frame(width: .infinity, height: 1, alignment: .leading)
                                        .opacity(0.1)
                                }
                                if isLoading{
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                        .scaleEffect(prop.isiPhoneS ? 2 : prop.isiPhoneM ? 2.5:3)
                                }
                            }
                            VStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                                HStack{
                                    Text("Email Address")
                                        .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14))
                                    Spacer()
                                    Text(userProfile.gmail)
                                        .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14))
                                }
                                Divider()
                                HStack{
                                    Text("Contact")
                                        .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14))
                                    Spacer()
                                    Text("0123456789")
                                        .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14))
                                        .foregroundColor(.gray)
                                }
                                Divider()
                                HStack{
                                    Text("Address")
                                        .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14))
                                    Spacer()
                                    Text("#Street, Village, Community, SR")
                                        .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14))
                                }
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
            }
            .setBG()
            .onAppear{
                userProfile.getProfileImage()
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
        .phoneOnlyStackNavigationView()
        .padOnlyStackNavigationView()
    }
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    func startFakeNetworkCall(){
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            uploadImg.uploadImg(mobileUserId: "62da268e137c7e3a92e53a56", profileImage: imageURL)
            userProfile.getProfileImage()
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
        Profile(logout: LoginViewModel(), uploadImg: UpdateMobileUserProfileImg(), Loading: .constant(false ), prop: prop)
    }
}

