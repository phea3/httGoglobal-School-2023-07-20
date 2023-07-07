//
//  ResponsiveContainer.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI

// MARK: Custom View which will return the properties of the view
struct ResponsiveView<Content: View>: View {
    // Returning properties
    var content: (Properties)->Content
    var body: some View {
        GeometryReader{ proxy in
            let size         =  proxy.size
            let isLanndscape =  (size.width > size.height)
            let isiPad       =  UIDevice.current.userInterfaceIdiom == .pad
            let isiPhone     =  UIDevice.current.userInterfaceIdiom == .phone
            let isiPhoneS    =  ((size.height >  476  && size.height <= 667)
                                 || ((size.width >  476  && size.width <= 667) && isLanndscape) ) && isiPhone
            let isiPhoneM    =  ((size.height >  667  && size.height <= 812)
                                 || ((size.width >  667  && size.width <= 812 ) && isLanndscape)) && isiPhone
            let isiPhoneL    =  ((size.height >  812  && size.height <  1024)
                                 || ((size.width >  812  && size.width <  1024) && isLanndscape)) && isiPhone
            let isiPadMini   =  ((size.height >= 1024 && size.height < 1152)
                                 || ((size.width >= 1024 && size.width < 1152) && isLanndscape)) && isiPad
            let isiPadPro    =  ((size.height >=  1152 && size.height <= 1366)
                                 || ((size.width >= 1152 && size.width <= 1366) && isLanndscape )) && isiPad
            
            content(Properties(isLandscape: isLanndscape, isiPad: isiPad, isiPhone: isiPhone,isiPhoneS: isiPhoneS,isiPhoneM: isiPhoneM,isiPhoneL: isiPhoneL,isiPadMini: isiPadMini,isiPadPro: isiPadPro, isSplit: isSplit(), size: size))
                .frame(width: size.width, height: size.height, alignment: .center)
                .onAppear{
                    // updating fraction on intial
                    updateFraction(fraction: isLanndscape && !isSplit() ? 0.3 : 0.5)
                }
                .onChange(of: isSplit(), perform: { newValue in
                    updateFraction(fraction: isLanndscape && !isSplit() ? 0.3 : 0.5)
                })
                .onChange(of: isLanndscape) { newValue in
                    updateFraction(fraction: newValue && !isSplit() ? 0.3:0.5)
                }
        }
    }
    // Solving UI for split apps
    func isSplit()->Bool{
        // Easy way to find
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return false
        }
        return screen.windows.first?.frame.size != UIScreen.main.bounds.size
        
    }
    func updateFraction(fraction: Double){
        NotificationCenter.default.post(name: NSNotification.Name("UPDATEFRACTION"), object: nil, userInfo: [
            "fraction":fraction
        ])
    }
}

struct Properties{
    var isLandscape: Bool
    var isiPad: Bool
    var isiPhone: Bool
    var isiPhoneS: Bool
    var isiPhoneM: Bool
    var isiPhoneL: Bool
    var isiPadMini : Bool
    var isiPadPro : Bool
    var isSplit: Bool
    var size: CGSize
    
}

// Fixing it by remove extra space for the help of navigation padding
struct PaddingMotifier: ViewModifier{
    @Binding var padding: CGFloat
    var props: Properties
    func body(content: Content) -> some View {
        content
            .overlay{
                GeometryReader{proxy in
                    Color.clear
                        .preference(key: Paddingkey.self, value: proxy.frame(in: .global))
                        .onPreferenceChange(Paddingkey.self) { value in
                            self.padding = -(value.minX / 3.3)
                        }
                }
            }
    }
}

// Preference key
struct Paddingkey: PreferenceKey{
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

// MARK: Display side bar always like iPad setting app
extension UISplitViewController{
    open override func viewDidLoad() {
        self.preferredDisplayMode = .twoOverSecondary
        self.preferredSplitBehavior = .displace
        //update primary view column fraction
        self.preferredPrimaryColumnWidthFraction = 0.4
        // Updating Dynamically with the help of NotificationCenter calls
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateView(notification:)), name: NSNotification.Name("UPDATEFRACTION"), object: nil)
    }
    @objc
    func UpdateView(notification: Notification){
        if let info = notification.userInfo, let fraction = info["fraction"] as? Double{
            self.preferredPrimaryColumnWidthFraction = fraction
        }
    }
}

struct CustomTabBar: View {
    @ObservedObject var appState = AppState.shared
    @Binding var currentTab: Tab
    // MARK: to Animation like Cureve
    @State var yOffset: CGFloat = 0
    var prop: Properties
    var body: some View {
        GeometryReader{ proxy in
            HStack(spacing: 0){
                ForEach(Tab.allCases, id: \.rawValue){ tab in
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)){
                            currentTab = tab
                            yOffset = -60
                        }
                        DispatchQueue.main.async {
                            appState.stu_id = nil
                            appState.actionofnoty = nil
                        }
                        // MARK: Resetting with Slight Delay
                        withAnimation(.easeInOut(duration: 0.1).delay(0.1)){
                            yOffset = 0
                        }
                    } label: {
                        Image(tab.rawValue)
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: prop.isiPhoneS ? 25 : prop.isiPhoneM ? 25 : 30, height: prop.isiPhoneS ? 25 : prop.isiPhoneM ? 25 : 30)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color.blue : .gray)
                        // MARK: Little Scaling Effect
                            .scaleEffect(currentTab == tab && yOffset != 0 ? 1.5 : 1)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxHeight: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 34 : prop.isiPhoneL ? 38 : 38)
        .padding(.bottom,prop.isiPhoneS ? 20 : prop.isiPhoneM ? 22 : 26)
        .padding([.horizontal,.top])
    }
}
