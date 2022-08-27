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
            let size = proxy.size
            let isLanndscape = (size.width > size.height)
            let isiPad = UIDevice.current.userInterfaceIdiom == .pad
            let isiPhone = UIDevice.current.userInterfaceIdiom == .phone
            let isiPhoneS = ((size.height > 476 && size.height <= 667) || (size.width > 476 && size.height <= 667))
            let isiPhoneM = ((size.height > 667  && size.height < 844) || (size.width > 667 && size.height <= 844))
            let isiPhoneL = ( (size.height >= 844) || (size.width >= 844))
            content(Properties(isLandscape: isLanndscape, isiPad: isiPad, isiPhone: isiPhone,isiPhoneS: isiPhoneS,isiPhoneM: isiPhoneM,isiPhoneL: isiPhoneL, isSplit: isSplit(), size: size))
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
        .frame(maxHeight: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20)
        .padding(.bottom,prop.isiPhoneS ? 18 : prop.isiPhoneM ? 20 : 24)
        .padding([.horizontal,.top])
    }
}
