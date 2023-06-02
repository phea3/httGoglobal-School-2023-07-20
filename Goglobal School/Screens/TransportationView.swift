//
//  Transportation.swift
//  Goglobal School
//
//  Created by Macmini on 31/5/23.
//

import SwiftUI
import UserNotifications

struct TransportationView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var delegate = NotificationDelegate()
    @State var DummyBoolean: Bool = false
    @State var show: Bool = false
    @State var currentProgress: CGFloat = 0.0
    @State var userProfileImg: String
    @State var reloadimgtoolbar: Bool = false
    @State var hidingDivider: Bool = false
    @State var refreshing: Bool = false
    @State var onAppearImg: Bool = true
    @State var viewLoading: Bool = false
    @Binding var bindingLanguage: String
    var barTitle: String = "សេវាកម្មដឹកជញ្ជូន"
    var prop: Properties
    var language: String
    var parentId: String
    var body: some View {
        if #available(iOS 16, *) {
            NavigationStack{
               
                VStack(spacing:0){
                    if DummyBoolean{
                        ZStack{
                            if viewLoading{
                                progressingView(prop: prop, language: self.language, colorScheme: colorScheme)
                            }else{
                                VStack{
                                    Text("មិនមានទិន្ន័យ!".localizedLanguage(language: self.language))
                                        .foregroundColor(.blue)
                                }
                               
                            }
                        }
                        .onAppear{
                            self.viewLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                self.viewLoading = false
                            }
                        }
                    }
                    else{
                        Divider()
                            .opacity(hidingDivider ? 0:1)
                        if refreshing {
                            Spacer()
                            progressingView(prop: prop, language: self.language, colorScheme: colorScheme)
                            Spacer()
                        }
                        else{
                            ZStack{
                                ScrollRefreshable(langauge: self.language, title: "កំពុងភ្ជាប់", tintColor: .blue){
                                    mainView()
                                        .padding(.bottom, prop.isiPhoneS ? 65 : prop.isiPhoneM ? 75 : prop.isiPhoneL ? 85 : 100)
                                        .padding(.horizontal, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                                        .navigationBarTitleDisplayMode(.inline)
                                        .toolbar {
                                            ToolbarItem(placement: .navigationBarLeading) {
                                                HStack{
                                                    Image(systemName: "line.3.horizontal.decrease")
                                                        .padding(.bottom, prop.isiPhoneS ? 3 : prop.isiPhoneM ? 4 : prop.isiPhoneL ? 5 : 5)
                                                    Text(barTitle.localizedLanguage(language: language))
                                                        .font(.custom("Bayon", size: prop.isiPhoneS ? 15 : prop.isiPhoneM ? 16 :  prop.isiPhoneL ? 18 : 20, relativeTo: .largeTitle))
                                                }
                                                .foregroundColor(Color("Blue"))
                                                .padding(.vertical, prop.isLandscape ? 20 : 0)
                                            }
                                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                                ChangeLanguage()
                                            }
                                            ToolbarItem(placement: .navigationBarTrailing) {
                                                if prop.isLandscape{
                                                    HStack{
                                                        if self.reloadimgtoolbar{
                                                            ProgressView()
                                                                .onAppear{
                                                                    self.reloadimgtoolbar = false
                                                                }
                                                        } else {
                                                            AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(userProfileImg)"), scale: 2){image in
                                                                
                                                                switch  image {
                                                                    
                                                                case .empty:
                                                                    ProgressView()
                                                                        .progressViewStyle(.circular)
                                                                        .frame(width: prop.isLandscape ? 30 : (prop.isiPhoneS ? 24 : prop.isiPhoneM ? 24 : 24), alignment: .center)
                                                                case .success(let image):
                                                                    image
                                                                        .resizable()
                                                                        .scaledToFill()
                                                                        .clipped()
                                                                        .background(Color.black.opacity(0.2))
                                                                        .overlay {
                                                                            Circle()
                                                                                .stroke(.orange, lineWidth: 1)
                                                                        }
                                                                        .clipShape(Circle())
                                                                        .padding(-5)
                                                                        .frame(width: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 :  20, alignment: .center)
                                                                case .failure:
                                                                    Image(systemName: "person.fill")
                                                                        .padding(5)
                                                                        .background(Color.white)
                                                                        .overlay {
                                                                            Circle()
                                                                                .stroke(.orange, lineWidth: 1)
                                                                        }
                                                                        .aspectRatio(contentMode: .fill)
                                                                        .clipShape(Circle())
                                                                        .frame(width: prop.isLandscape ? 14 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : prop.isiPhoneL ? 20 : 22), alignment: .center)
                                                                        .onAppear{
                                                                            if !userProfileImg.isEmpty{
                                                                                self.reloadimgtoolbar = true
                                                                            }
                                                                        }
                                                                    
                                                                @unknown default:
                                                                    fatalError()
                                                                    
                                                                }
                                                            }
                                                        }
                                                    }
                                                    .padding(.vertical, 10 )
                                                }else{
                                                    HStack{
                                                        if self.reloadimgtoolbar{
                                                            ProgressView()
                                                                .onAppear{
                                                                    self.reloadimgtoolbar = false
                                                                }
                                                        } else {
                                                            AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(userProfileImg)"), scale: 2){image in
                                                                
                                                                switch  image {
                                                                    
                                                                case .empty:
                                                                    ProgressView()
                                                                        .progressViewStyle(.circular)
                                                                        .frame(width: prop.isLandscape ? 30 : (prop.isiPhoneS ? 24 : prop.isiPhoneM ? 24 : 24), alignment: .center)
                                                                case .success(let image):
                                                                    image
                                                                        .resizable()
                                                                        .scaledToFill()
                                                                        .clipped()
                                                                        .background(Color.black.opacity(0.2))
                                                                        .overlay {
                                                                            Circle()
                                                                                .stroke(.orange, lineWidth: 1)
                                                                        }
                                                                        .clipShape(Circle())
                                                                        .padding(-5)
                                                                        .frame(width: prop.isLandscape ? 14 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20), alignment: .center)
                                                                case .failure:
                                                                    Image(systemName: "person.fill")
                                                                        .padding(5)
                                                                        .font(.system(size:  prop.isLandscape ? 22 : (prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18)))
                                                                        .background(Color.white)
                                                                        .overlay {
                                                                            Circle()
                                                                                .stroke(.orange, lineWidth: 1)
                                                                        }
                                                                        .aspectRatio(contentMode: .fill)
                                                                        .clipShape(Circle())
                                                                        .frame(width: prop.isLandscape ? 14 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20), alignment: .center)
                                                                        .onAppear{
                                                                            if !userProfileImg.isEmpty{
                                                                                self.reloadimgtoolbar = true
                                                                            }
                                                                        }
                                                                @unknown default:
                                                                    fatalError()
                                                                }
                                                            }
                                                        }
                                                       
                                                    }
                                                }
                                            }
                                            
                                        }
                                }
                                if !onAppearImg{
                                    ZStack{
                                        Color(colorScheme == .dark ? "Black" : "BG")
                                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                                            .ignoresSafeArea()
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
                .setBG(colorScheme: colorScheme)
                .onAppear{
                    UIApplication.shared.applicationIconBadgeNumber = 0
                }
            }
            .padOnlyStackNavigationView()
            .phoneOnlyStackNavigationView()
            .refreshable {
                do {
                    try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
                } catch {}
                self.hidingDivider = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.hidingDivider = false
                }
                refreshingView()
                
            }
        } else {
            NavigationView{
                Text("Transportation")
                    .setBG(colorScheme: colorScheme)
                    .onAppear{
                        UIApplication.shared.applicationIconBadgeNumber = 0
                    }
            }
            .padOnlyStackNavigationView()
            .phoneOnlyStackNavigationView()
        }
    }
    private func mainView()-> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0){
              
               
                if #available(iOS 16.0, *) {
                    ZStack {
                        Color("Nice Green")
                            .ignoresSafeArea()
                        VStack {
                            Button(action: delegate.createNotification) {
                                Text("Notify User")
                            }
                            .onAppear {
                                delegate.requestAuthorization()
                            }
                            Text("Notification Interactions \(delegate.notificationCounter)")
                        }
                    }
                    .navigationDestination(isPresented: $delegate.show) {
                        Detail(show: delegate.show)
                    }
                    
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        .onAppear{
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Detail"), object: nil, queue: .main) { (_) in
                self.show = true
            }
        }
    }
   
    private func refreshingView(){
        self.refreshing = true
        self.onAppearImg = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshing = false
        }
    }
    
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
}

struct TransportationView_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        TransportationView(userProfileImg: "",bindingLanguage: .constant(""), prop: prop,language: "em", parentId: "")
    }
}

struct Detail: View {
    @State var show: Bool
    var body: some View{
        Button{
            self.show = false
        }label: {
            Text("back")
        }
            .navigationTitle("Detail View")
    }
}

class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    
    @Published var notificationCounter = 0
    @Published var show = false
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) {(_,_) in
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        self.show = true
        completionHandler([.badge, .banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "Okay" {
            self.show = true
            print("Hello")
            print("counter is " + String(notificationCounter))
            notificationCounter = notificationCounter + 1
            print("counter is now " + String(notificationCounter))
        }
        completionHandler()
    }
    
    func createNotification() {
        let content = UNMutableNotificationContent()
        content.title = "God of Posture"
        content.subtitle = "Straighten Your Neck"
        content.categoryIdentifier = "Actions"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
        let request = UNNotificationRequest(identifier: "In-App", content: content, trigger: trigger)
        
        //notification actions
        
        let close = UNNotificationAction(identifier: "Close", title: "Close", options: .destructive)
        let okay = UNNotificationAction(identifier: "Okay", title: "Okay", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "Actions", actions: [close, okay], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
