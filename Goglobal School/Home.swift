//
//  Home.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI
import Alamofire
import SDWebImageSwiftUI

struct Home: View {
    @StateObject var loginVM: LoginViewModel = LoginViewModel()
    // MARK: Hiding Native One
    init(){UITabBar.appearance().isHidden = true}
    @State var currentTab: Tab = .dashboard
    @State var animationFinished: Bool = false
    @State var animationStarted: Bool = false
//    @State var gmail: String = "loklundy@gmail.com"
//    @State var password: String = "123456789"
    @State var forget: Bool = false
    @State var isempty: Bool = false
        @State var gmail: String = ""
        @State var password: String = ""
    @State var isLoading: Bool = false
    @State var showContact: Bool = false
    let lightGrayColor = Color.white
    
    
    var body: some View {
        ResponsiveView{ prop in
            ZStack{
                ImageBackgroundSignIn()
                if loginVM.isAuthenticated{
                    MainView(prop: prop)
                }else{
                    LoginView(prop: prop)
                }
                FlashScreen(prop:prop)
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea(.container, edges: .leading)
    }
    @ViewBuilder
    func MainView(prop: Properties)-> some View{
        ZStack{
            TabView(selection: $currentTab){
                // MARK: Need to Apply BG For Each Tab View
                Dashboard(isLoading: $isLoading, parentId: loginVM.userId, prop: prop)
                    .tag(Tab.dashboard)
                Education(isLoading: $isLoading, parentId: loginVM.userId, prop: prop)
                    .tag(Tab.education)
                Calendar(isLoading: $isLoading, prop: prop)
                    .tag(Tab.bag)
                Profile(logout: loginVM, uploadImg: UpdateMobileUserProfileImg(), Loading: $isLoading, prop: prop)
                    .tag(Tab.book)
            }
            // MARK: Custom to Bar
            CustomTabBar(currentTab: $currentTab,prop: prop)
                .background(RoundedCorners(color: .white, tl: 30, tr: 30, bl: 0, br: 0))
                .frame(maxWidth: prop.isLandscape || prop.isSplit ? 400 : prop.isiPad ? 400 : .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    @ViewBuilder
    func FlashScreen(prop: Properties)-> some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            ImageBackgroundSignIn()
            VStack{
                Spacer()
                LogoGoglobal(prop:prop)
                Spacer()
                footer(prop: prop)
            }
            .padding()
        }
        .opacity(animationFinished ? 0:1)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 0.7)){
                    animationFinished = true
                }
            }
        }
    }
    
    @ViewBuilder
    func LoginView(prop: Properties)-> some View{
        
        ZStack{
            VStack{
                Spacer()
                LogoGoglobal(prop: prop)
                Spacer()
                Text("ចូលប្រើកម្មវិធី")
                    .font(.custom("Bayon", size: prop.isiPhoneS ? 26 : prop.isiPhoneM ? 28 : prop.isiPhoneL ? 30 : 40, relativeTo: .largeTitle))
                    .foregroundColor(Color("ColorTitle"))
                Spacer()
                VStack(spacing:30){
                    VStack(alignment: .leading, spacing: prop.isiPhoneS ? 4 : prop.isiPhoneM ? 6 : prop.isiPhoneL ? 8 : 10) {
                        Text("អ៊ីម៉ែល")
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : prop.isiPhoneL ? 20 : 22, relativeTo: .body))
                        let binding = Binding<String>(get: {
                            self.gmail
                        }, set: {
                            self.gmail = $0.lowercased()
                        })
                        TextField("បញ្ជូលអ៊ីម៉ែលរបស់អ្នក", text: binding)
                        //                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : prop.isiPhoneL ? 20 : 22, relativeTo: .body))
                            .padding(prop.isiPhoneS ? 13 : prop.isiPhoneM ? 15 : prop.isiPhoneL ? 20 : 20)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray.opacity(0.5), lineWidth: 1)
                            )
                    }
                    
                    VStack(alignment: .leading, spacing: prop.isiPhoneS ? 4 : prop.isiPhoneM ? 6 : prop.isiPhoneL ? 8 : 10) {
                        Text("ពាក្យសម្ងាត់")
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : prop.isiPhoneL ? 20 : 22, relativeTo: .body))
                        SecureField("បញ្ជូលពាក្យសម្ងាត់របស់អ្នក", text: $password)
                        //                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : prop.isiPhoneL ? 20 : 22, relativeTo: .body))
                            .padding(prop.isiPhoneS ? 13 : prop.isiPhoneM ? 17 : prop.isiPhoneL ? 19 : 20)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray.opacity(0.5), lineWidth: 1)
                            )
                    }
                    
                    Button {
                        loginVM.login(email: gmail, password: password)
                        self.isLoading = true
                        if self.gmail.isEmpty || password.isEmpty {
                            self.isempty = true
                            self.isLoading = false
                        }else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                if !loginVM.isAuthenticated{
                                    self.isLoading = false
                                    self.forget = true
                                }
                            }
                        }
                    } label: {
                        Text("ចូលកម្មវិធី")
                            .font(.custom("Bayon", size: prop.isiPhoneS ? 20 : prop.isiPhoneM ? 24 : prop.isiPhoneL ? 26 : 30, relativeTo: .largeTitle))
                            .foregroundColor(.white)
                            .padding(prop.isiPhoneS ? 3 : prop.isiPhoneM ? 4 : prop.isiPhoneL ? 6 : 8)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                        
                    }
                }
                .frame(maxWidth: prop.isiPad ? 400 : prop.isiPhoneL ? 400 : .infinity )
                if isempty{
                    Text("សូមសរសេរអ៊ីម៉ែល & ពាក្យសម្ងាត់")
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18, relativeTo: .body))
                        .foregroundColor(Color("Blue"))
                }
                
                Spacer()
                
                if forget{
                    Button {
                        self.showContact = true
                    } label: {
                        Text("ភ្លេចពាក្យសម្ងាត់?")
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 : 22, relativeTo: .body))
                    }
                    .sheet(isPresented: $showContact) {
                        SheetContact(prop: prop)
                    }
                }
                footer(prop: prop)
            }
            .padding()
            if isLoading{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(prop.isiPhoneS ? 2 : prop.isiPhoneM ? 2.5:3)
            }
        }
    }
    func footer(prop:Properties)-> some View{
        VStack(spacing:  prop.isiPhoneS ? 2 : prop.isiPhoneM ? 3 : prop.isiPhoneL ? 5 : 10){
            Text("Power by:")
                .font(.system( size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 : 20))
                .foregroundColor(Color("footerColor"))
            Text("Go Global Tech")
                .font(.system(size: prop.isiPhoneS ? 18 : prop.isiPhoneM ? 22 : prop.isiPhoneL ? 24 : 28).bold())
                .foregroundColor(Color("footerColor"))
            FooterImg(prop: prop)
                .padding(.top, 8)
        }
    }
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
