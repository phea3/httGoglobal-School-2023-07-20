
import SwiftUI
import Alamofire
import ImageViewer
import LocalAuthentication

struct Home: View {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.openURL) var openURL
    @StateObject var loginVM: LoginViewModel = LoginViewModel()
    @StateObject var userProfile: MobileUserViewModel = MobileUserViewModel()
    @StateObject var academiclist: ListViewModel =  ListViewModel()
    @StateObject var students: ListStudentViewModel = ListStudentViewModel()
    @StateObject var sendToken: UploadDeviceToken = UploadDeviceToken()
    @StateObject var DeviceUserLogOut: MobileUserLogOutViewModel = MobileUserLogOutViewModel()
    @StateObject var AnnoucementList: AnnouncementViewModel = AnnouncementViewModel()
    @StateObject var AllClasses: ScheduleViewModel = ScheduleViewModel()
    @StateObject var Attendance: ListAttendanceViewModel = ListAttendanceViewModel()
    @StateObject var monitor = Monitor()
    
    init(){
        requestPushAuthorization();
        UITabBar.appearance().isHidden = true
    }
    
    @State var currentTab: Tab = .dashboard
    @State var animationFinished: Bool = false
    @State var animationStarted: Bool = false
    @State var gmail: String = (UserDefaults.standard.string(forKey: "Gmail") ?? "")
    @State var pass: String = (UserDefaults.standard.string(forKey: "Password") ?? "")
    @State var forget: Bool = false
    @State var isempty: Bool = false
    @State var isLoading: Bool = false
    @State var showContact: Bool = false
    @State var hideTab: Bool = false
    @State var checkState: Bool = true
    @State var loggedIn: Bool = false
    @State var showingAlert: Bool = false
    @State var showingPassword: Bool = false
    @State var showingAlertUpdate = true
    @State var value: CGFloat = 0
    @State var hidefooter: Bool = false
    @State var image = Image("GoGlobalSchool")
    @State var newToken: String = ""
    @State private var isUnlocked = false
    enum Field {
            case gmail, pass
        }
    @FocusState private var focusedField: Field?
    var body: some View {
        
        // MARK: Resposive App
        ResponsiveView { prop in
            // Login process
            ZStack{
                // MARK: background image
                ImageBackgroundSignIn()
                
                if loginVM.isAuthenticated && ( gmail != "" && pass != "" ){
                    ZStack{
                        if !loggedIn{
                            EmptyView()
                                .setBG()
                        }else{
                            MainView(prop: prop)
                        }
                    }
                    .onAppear{
                        //login mutation
                        loginVM.login(email: gmail, password: pass, checkState: checkState)
                        
                        // ask for notification
//                        loginVM.AskUserForNotification()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            // get active year
                            academiclist.activeAcademicYear()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            loggedIn = true
                            if self.newToken != "" {
                                // send token to backend
                                sendToken.uploadToken(mobileUserId: loginVM.userprofileId, newToken:TokenInput(plateformToken: "ios", deviceToken: self.newToken))
                            }
                        }
                    }
                }else{
                    
                    // login screen
                    LoginView(prop: prop)
                }
                // animation loading
                FlashScreen(animationFinished: self.animationFinished, prop:prop)
            }
            .alert("គ្មានអ៉ីនធើណេត", isPresented: .constant(!monitor.connected)) {
                Button("OK", role: .cancel) { }
            }
            .onAppear{
                registerForNotifications()
                VersionCheck.shared.checkAppStore()
                monitor.checkConnection()
                DispatchQueue.main.asyncAfter(deadline:.now()+2) {
                    self.newToken = ApiTokenSingleton.shared.token
                }
                if !loginVM.isAuthenticated{
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(.container, edges: .leading)
    }
    
    @ViewBuilder
    //MARK: Main View or Tab View of Each Screen
    func MainView(prop: Properties)-> some View{
        ZStack{
            TabView(selection: $currentTab){
                Dashboard(userProfileImg: loginVM.userProfileImg, isLoading: $isLoading, parentId: loginVM.userId, activeYear: academiclist.academicYearId, prop: prop, mobileUserId: loginVM.userprofileId)
                    .tag(Tab.dashboard)
                Education(userProfileImg: loginVM.userProfileImg, isLoading: $isLoading, parentId: loginVM.userId, academicYearName: academiclist.khmerYear, prop: prop)
                    .tag(Tab.education)
                CalendarViewModel(userProfileImg: loginVM.userProfileImg, isLoading: $isLoading, prop: prop, activeYear: academiclist.academicYearId)
                    .tag(Tab.bag)
                Profile(logout: loginVM, uploadImg: UpdateMobileUserProfileImg(), Loading: $isLoading, hideTab: $hideTab, checkState: $checkState, prop: prop, devicetoken: self.newToken)
                    .tag(Tab.book)
            }
            .alert("សូមធ្វើការដំឡើង Version \(VersionCheck.shared.appStoreVersion ?? "") នៅក្នុង App Store!", isPresented: .constant(VersionCheck.shared.newVersionAvailable ?? false)) {
                Button("យល់ព្រម") {
                    openURL(URL(string: VersionCheck.shared.appLinkToAppStore ?? "")!)
                    DeviceUserLogOut.MobileUserLogOut(mobileUserId: loginVM.userprofileId, token: self.newToken)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        loginVM.signout()
                        Attendance.clearCache()
                        UserDefaults.standard.removeObject(forKey: "DeviceToken")
                    }
                    UserDefaults.standard.removeObject(forKey: "Gmail")
                    UserDefaults.standard.removeObject(forKey: "Password")
                    UserDefaults.standard.removeObject(forKey: "isAuthenticated")
                }
//                Button("មិនយល់ព្រម", role: .cancel)  { }
            }
            // MARK: Custom to Bar
            CustomTabBar(currentTab: $currentTab,prop: prop)
                .background(RoundedCorners(color: .white, tl: 30, tr: 30, bl: 0, br: 0))
                .frame(maxWidth: prop.isLandscape || prop.isSplit ? 400 : prop.isiPad ? 400 : .infinity, maxHeight: .infinity, alignment: .bottom)
                .opacity( hideTab ? 0 : animationStarted ? 1:0)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.easeInOut(duration: 1)){
                            animationStarted = true
                        }
                    }
                }
        }
    }
    
    // MARK: View of login Screen
    func LoginView(prop: Properties)-> some View{
        ZStack{
            Rectangle()
                .fill(.white)
                .frame(maxWidth:.infinity,maxHeight:.infinity)
            ImageBackgroundSignIn()
            VStack{
                Spacer()
                LogoGoglobal(prop:prop)
                    .opacity(prop.isLandscape && prop.isiPhone ? 0:1)
                VStack{
                    Text("ចូលប្រើកម្មវិធី")
                        .font(.custom("Bayon", size: prop.isiPhoneS ? 21 : prop.isiPhoneM ? 23 : prop.isiPhoneL ? 25 : 27, relativeTo: .largeTitle))
                        .foregroundColor(Color("ColorTitle"))
                }
                .opacity(prop.isLandscape && prop.isiPhone ? 0:1)
                if !hidefooter{
                    Spacer()
                }
                VStack(spacing: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 : 20){
                    VStack(alignment: .leading, spacing: prop.isiPhoneS ? 4 : prop.isiPhoneM ? 6 : prop.isiPhoneL ? 8 : 10) {
                        Text("អ៉ីម៉ែល")
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 15 : prop.isiPhoneM ? 17 : prop.isiPhoneL ? 19 : 21, relativeTo: .body))
                            .foregroundColor(.blue)
                        let binding = Binding<String>(get: {
                            self.gmail
                        }, set: {
                            self.gmail = $0.lowercased()
                        })
                        TextField("បញ្ជូលអ៉ីម៉ែល", text: binding)
                            .textContentType(.emailAddress)
                            .focused($focusedField, equals: .gmail)
                            .padding(prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18)
                            .cornerRadius(10)
                            .submitLabel(.next)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(isempty ? .red:.blue.opacity(0.5), lineWidth: 1)
                            )
                    }
                    VStack(alignment: .leading, spacing: prop.isiPhoneS ? 4 : prop.isiPhoneM ? 6 : prop.isiPhoneL ? 8 : 10) {
                        Text("ពាក្យសម្ងាត់")
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 15 : prop.isiPhoneM ? 17 : prop.isiPhoneL ? 19 : 21, relativeTo: .body))
                            .foregroundColor(.blue)
                        SecureTextFieldToggle(text: $pass, isempty: isempty, prop: prop)
                            .textContentType(.password)
                            .focused($focusedField, equals: .pass)
                            .submitLabel(.return)
                            .onSubmit {
                                print("Password")
                            }
                    }
                    VStack{
                        Button {
                            // login mutation
                            
                            loginVM.login(email: gmail, password: pass, checkState: checkState)
                            self.isLoading = true
                            
                            if self.gmail.isEmpty || pass.isEmpty {
                                self.isempty = true
                                self.isLoading = false
                                
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7 ) {
                                    if loginVM.failLogin{
                                        self.isLoading = false
                                        self.forget = true
                                        if loginVM.failLogin{
                                            showingAlert = true
                                        }
                                    }else{
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                            if !loginVM.isAuthenticated{
                                                self.isLoading = false
                                                self.forget = true
                                                if loginVM.failLogin{
                                                    showingAlert = true
                                                }
                                            }else{
                                                if self.newToken != "" {
                                                    UserDefaults.standard.set(self.newToken, forKey: "DeviceToken")
                                                    sendToken.uploadToken(mobileUserId: loginVM.userprofileId, newToken:TokenInput(plateformToken: "ios", deviceToken: self.newToken))
                                                }
                                                if !loginVM.failLogin && loginVM.isAuthenticated{
                                                    DispatchQueue.main.async{
                                                        self.isLoading = false
                                                        self.forget = false
                                                        self.isempty = false
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    
                                }
                            }
                            if checkState{
                                
                                UserDefaults.standard.set(self.gmail, forKey: "Gmail")
                                UserDefaults.standard.set(self.pass, forKey: "Password")
                                
                            }
                            
                        } label: {
                            
                            Text("ចូលកម្មវិធី")
                                .font(.custom("Bayon", size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : prop.isiPhoneL ? 22 : 24, relativeTo: .largeTitle))
                                .foregroundColor(.white)
                                .padding(prop.isiPhoneS ? 6 : prop.isiPhoneM ? 7 : prop.isiPhoneL ? 8 : 10)
                                .frame(maxWidth: .infinity)
                                .background(.blue)
                                .cornerRadius(10)
                        }
                        .alert("គណនីរបស់លោកអ្នកមិនត្រឹមត្រូវទេ", isPresented: $showingAlert) {
                            Button("OK", role: .cancel) { loginVM.failLogin = false }
                        }
                        HStack(spacing: 0){
                            
                            Button(action:
                                    {
                                self.checkState.toggle()
                            }) {
                                HStack(alignment: .center, spacing: 10) {
                                    Image(systemName: self.checkState ? "checkmark.square" : "square")
                                        .font(.system(size: 20))
                                        .padding(.bottom, 5)
                                    Text("ចងចាំពាក្យសម្ងាត់?")
                                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 11 : prop.isiPhoneM ? 13 : prop.isiPhoneL ? 15 : 17, relativeTo: .body))
                                        .foregroundColor(.blue)
                                }
                            }
                            
                            Spacer()
                            
                            Button {
                                self.showContact = true
                            } label: {
                                Text("ភ្លេចពាក្យសម្ងាត់?")
                                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 11 : prop.isiPhoneM ? 13 : prop.isiPhoneL ? 15 : 17, relativeTo: .body))
                                    .foregroundColor(forget ? .red : .blue)
                            }
                            .sheet(isPresented: $showContact) {
                                SheetContact(prop: prop)
                            }
                            
                        }
                        .padding(.horizontal,2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top,5)
                }
                .frame(maxWidth: prop.isiPad ? 400 : prop.isiPhone ? 400 : .infinity )
                
                if !hidefooter{
                    Spacer()
                }
                footer(prop: prop)
                    .opacity(prop.isLandscape && prop.isiPhone ? 0 : 1)
                
            }
            .offset(y: -self.value)
            .animation(.spring(), value: self.value)
            .onAppear{
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                    let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    self.hidefooter = true
                    self.value = height
                }
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                    self.hidefooter = false
                    self.value = 0
                }
            }
            .padding(prop.isiPhoneS ? 25: prop.isiPhoneM ? 30 : prop.isiPhoneL ? 35 : 40)
            
            if isLoading{
                ZStack{
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 100, height: 100, alignment: .center)
                        .cornerRadius(20)
                    VStack{
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(prop.isiPhoneS ? 1 : prop.isiPhoneM ? 1: prop.isiPhoneL ? 1 : 1)
                        Text("កំពុងភ្ជាប់")
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    func footer(prop:Properties)-> some View{
        VStack(spacing:  prop.isiPhoneS ? 1 : prop.isiPhoneM ? 2 : prop.isiPhoneL ? 3 : 10){
            Text("Power by:")
                .font(.system( size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 : 20))
                .foregroundColor(Color("footerColor"))
            Text("Go Global IT")
                .font(.system(size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : prop.isiPhoneL ? 20 : 22).bold())
                .foregroundColor(Color("footerColor"))
            FooterImg(prop: prop)
                .padding(.top, 8)
        }
    }
    // MARK: ASK USER FOR NOTIFICATIOON
    func requestPushAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("")
//                Push Notification Allowed
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    // MARK: GET DEVICE's token
    func registerForNotifications() {
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    // MARK: TouchID & FaceID
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    // authenticated successfully
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
            print("error")
        }
    }
}

struct SecureTextFieldToggle: View{
    @State var isSecureField: Bool = true
    @Binding var text: String
    var isempty: Bool
    var prop: Properties
    var body: some View{
        
        HStack{
            HStack{
                if isSecureField{
                    SecureField("បញ្ជូលពាក្យសម្ងាត់", text: $text)
                }else{
                    let binding = Binding<String>(get: {
                        self.text
                    }, set: {
                        self.text = $0.lowercased()
                    })
                    TextField("បញ្ជូលពាក្យសម្ងាត់", text: binding)
                }
            }
            Spacer()
            Button {
                self.isSecureField.toggle()
            } label: {
                Image(systemName: self.isSecureField ?  "eye.slash.fill" : "eye.fill" )
                    .foregroundColor(.blue)
            }
        }
        .padding(prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isempty ? .red : .blue .opacity(0.5), lineWidth: 1)
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


