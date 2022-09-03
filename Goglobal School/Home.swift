//
//  Home.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI
import Alamofire
import SDWebImageSwiftUI
import SwiftUITooltip

struct Home: View {
    @ObservedObject var loginVM: LoginViewModel = LoginViewModel()
    init(){
        UITabBar.appearance().isHidden = true
        self.tooltipConfig.enableAnimation = true
        self.tooltipConfig.animationOffset = 10
        self.tooltipConfig.animationTime = 1
        self.tooltipConfig.borderColor = .white
    }
    
    @State var currentTab: Tab = .dashboard
    @State var animationFinished: Bool = false
    @State var animationStarted: Bool = false
    @State var gmail: String = (UserDefaults.standard.string(forKey: "Gmail") ?? "")
    @State var password: String = (UserDefaults.standard.string(forKey: "Password") ?? "")
    @State var forget: Bool = false
    @State var isempty: Bool = false
    @State var isLoading: Bool = false
    @State var showContact: Bool = false
    @State var hideTab: Bool = false
    @State var checkState: Bool = false
    @State var loggedIn: Bool = false
    @State var tooltipVisible = true
    
    var tooltipConfig = DefaultTooltipConfig()
    let lightGrayColor = Color.white
    
    var body: some View {
        ResponsiveView{ prop in
            ZStack{
                ImageBackgroundSignIn()
                if loginVM.isAuthenticated{
                    ZStack{
                        if !loggedIn{
                            progressingView(prop: prop)
                        }else{
                            MainView(prop: prop)
                        }
                    }
                    .onAppear{
                        loginVM.login(email: gmail, password: password, checkState: checkState)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            loggedIn = true
                        }
                    }
                }
                else if (!gmail.isEmpty && !gmail.isEmpty) && loginVM.isAuthenticated {
                    EmptyView()
                        .onAppear{
                            loginVM.login(email: gmail, password: password, checkState: checkState)
                        }
                    
                }else if !loginVM.isAuthenticated{
                    LoginView(prop: prop)
                }else{
                    progressingView(prop: prop)
                }
                FlashScreen(prop:prop)
            }
            .ignoresSafeArea()
            .onAppear{
                if !loginVM.isAuthenticated{
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            }
        }
        .ignoresSafeArea(.container, edges: .leading)
    }
    @ViewBuilder
    func MainView(prop: Properties)-> some View{
        ZStack{
            TabView(selection: $currentTab){
                // MARK: Need to Apply BG For Each Tab View
                Dashboard(userProfileImg: loginVM.userProfileImg, isLoading: $isLoading, parentId: loginVM.userId, prop: prop)
                    .tag(Tab.dashboard)
                Education(userProfileImg: loginVM.userProfileImg, isLoading: $isLoading, parentId: loginVM.userId, prop: prop)
                    .tag(Tab.education)
                Calendar(userProfileImg: loginVM.userProfileImg, isLoading: $isLoading, prop: prop)
                    .tag(Tab.bag)
                Profile(logout: loginVM, uploadImg: UpdateMobileUserProfileImg(), Loading: $isLoading, hideTab: $hideTab, checkState: $checkState, prop: prop)
                    .tag(Tab.book)
            }
            // MARK: Custom to Bar
            CustomTabBar(currentTab: $currentTab,prop: prop)
                .tooltip(self.tooltipVisible, side: .topLeft,config: tooltipConfig) {
                    HStack{
                        Text("ជម្រើស")
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 : 22, relativeTo: .body))
                            .foregroundColor(.blue)
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    self.tooltipVisible = !self.tooltipVisible
                                }
                            }
                    }
                }
                .background(RoundedCorners(color: .white, tl: 30, tr: 30, bl: 0, br: 0))
                .frame(maxWidth: prop.isLandscape || prop.isSplit ? 400 : prop.isiPad ? 400 : .infinity, maxHeight: .infinity, alignment: .bottom)
                .opacity( hideTab ? 0 : animationStarted ? 1:0)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.easeInOut(duration: 0.7)){
                            animationStarted = true
                        }
                    }
                }
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
                VStack{
                    Text("ចូលប្រើកម្មវិធី")
                        .font(.custom("Bayon", size: prop.isiPhoneS ? 26 : prop.isiPhoneM ? 28 : prop.isiPhoneL ? 30 : 40, relativeTo: .largeTitle))
                        .foregroundColor(Color("ColorTitle"))
                    if isempty{
                        Text("សូមសរសេរអ៊ីម៉ែល & ពាក្យសម្ងាត់")
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18, relativeTo: .body))
                            .foregroundColor(Color("Blue"))
                    }
                    if forget{
                        Button {
                            self.showContact = true
                        } label: {
                            Text("ភ្លេចពាក្យសម្ងាត់មែនទេ?")
                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 : 22, relativeTo: .body))
                        }
                        .sheet(isPresented: $showContact) {
                            SheetContact(prop: prop)
                        }
                    }
                }
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
                            .keyboardType(.emailAddress)
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
                            .textContentType(.password)
                            .padding(prop.isiPhoneS ? 13 : prop.isiPhoneM ? 17 : prop.isiPhoneL ? 19 : 20)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray.opacity(0.5), lineWidth: 1)
                            )
                    }
                    
                    Button {
                        loginVM.login(email: gmail, password: password, checkState: checkState)
                        self.isLoading = true
                        if self.gmail.isEmpty || password.isEmpty {
                            self.isempty = true
                            self.isLoading = false
                        }else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                if !loginVM.isAuthenticated{
                                    self.isLoading = false
                                    self.forget = true
                                }else{
                                    DispatchQueue.main.async{
                                        self.isLoading = false
                                    }
                                }
                            }
                        }
                        if checkState{
                            UserDefaults.standard.set(self.gmail, forKey: "Gmail")
                            UserDefaults.standard.set(self.password, forKey: "Password")
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
                Spacer()
                VStack(spacing: 0){
                    Button(action:
                            {
                        //1. Save state
                        self.checkState.toggle()
                        print("State : \(self.checkState)")
                    }) {
                        HStack(alignment: .center, spacing: 10) {
                            //2. Will update according to state
                            Image(systemName: self.checkState ?"checkmark.square": "square")
                                .font(.system(size: 30))
                                .tooltip(.right, config: tooltipConfig) {
                                    Text("ចងចាំពាក្យសម្ងាត់?")
                                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 : 22, relativeTo: .body))
                                        .foregroundColor(.blue)
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                footer(prop: prop)
            }
            .padding()
            if isLoading{
               progressingView(prop: prop)
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
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
