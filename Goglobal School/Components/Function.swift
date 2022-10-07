//
//  Function.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import Foundation
import SwiftUI

//Extending Date to get Current Month Dates...
extension Date{
    func getAllDate()->[Date]{
        let calendar = NSCalendar.current
        // Getting Start Date...
        let startDate = calendar.date(from: NSCalendar.current.dateComponents([.year,.month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        // Getting Date...
        return range.compactMap{day -> Date in
            return calendar.date(byAdding: .day, value: day - 1 , to: startDate)!
        }
    }
}
extension View{
    func hideKeyboard() {
          let resign = #selector(UIResponder.resignFirstResponder)
          UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
      }
    func getGradientOverlay() -> some View {
        LinearGradient(gradient:
                        Gradient(stops: [
                            .init(color: Color.white.opacity(0), location: 0),
                            .init(color: Color.white.opacity(0.9), location: 1.0)
                        ]),
                       startPoint: .top,
                       endPoint: .bottom
        )
    }
    func imageStuBG(prop: Properties)->some View{
        Image("DashboadBg")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: prop.isiPadPro ? 400 : prop.isiPadMini ? 450 : prop.isLandscape && prop.isiPad ? 600 : prop.isLandscape && prop.isiPhoneS ? 360 : prop.isLandscape && prop.isiPhoneM ? 370 : prop.isLandscape && prop.isiPhoneL ? 380 : .infinity)
    }
    func graduatedLogo()->some View{
        Circle()
            .font(.system(size: 50))
            .frame(width: 49, height: 49, alignment: .center)
            .overlay(
                Image(systemName: "graduationcap.circle.fill")
                    .font(.system(size: 50))
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(.white)
            )
    }
    func FooterImg(prop: Properties)-> some View{
        Image("Footer")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth:prop.isiPhoneS ? 80 : prop.isiPhoneM ? 90 : prop.isiPhoneL ? 100 : 140)
    }
    func LogoGoglobal(prop:Properties)->some View {
        Image("GoGlobalSchool")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: prop.isiPadMini ? 140 : prop.isiPadPro  ? 160 : prop.isiPhoneS ? 90 : prop.isiPhoneM ? 100 : prop.isiPhoneL ? 120 :  140)
        
    }
    func ImageBackgroundSignIn()->some View{
        Image("Background")
            .resizable()
            .ignoresSafeArea()
    }
    func toolbarView(prop:Properties, barTitle: String, profileImg: String)->some View {
        self
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack{
                        Image(systemName: "line.3.horizontal.decrease")
                            .padding(.bottom, prop.isiPhoneS ? 3 : prop.isiPhoneM ? 4 : prop.isiPhoneL ? 5 : 5)
                        Text(barTitle)
                            .font(.custom("Bayon", size: prop.isiPhoneS ? 15 : prop.isiPhoneM ? 16 :  prop.isiPhoneL ? 18 : 20, relativeTo: .largeTitle))
                    }
                    .foregroundColor(Color("Blue"))
                    .padding(.vertical, prop.isLandscape ? 20 : 0)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if prop.isLandscape{
                        HStack{
                            AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(profileImg)"), scale: 2){image in
                                
                                switch  image {
                                    
                                case .empty:
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                        .frame(width: prop.isLandscape ? 30 : (prop.isiPhoneS ? 24 : prop.isiPhoneM ? 24 : 24), alignment: .center)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .cornerRadius(50)
                                        .clipped()
                                        .background(Color.black.opacity(0.2))
                                        .clipShape(Circle())
                                        .padding(-5)
                                        .frame(width: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 :  20, alignment: .center)
                                case .failure:
                                    Image(systemName: "person.fill")
                                        .padding(2)
                                        .cornerRadius(50)
                                        .background(Color.white)
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .frame(width: prop.isLandscape ? 14 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 22), alignment: .center)
                                @unknown default:
                                    fatalError()
                                }
                            }
                        }
                        .padding(.vertical, 10 )
                    }else{
                        HStack{
                            AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(profileImg)"), scale: 2){image in
                                
                                switch  image {
                                    
                                case .empty:
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                        .frame(width: prop.isLandscape ? 30 : (prop.isiPhoneS ? 24 : prop.isiPhoneM ? 24 : 24), alignment: .center)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .cornerRadius(50)
                                        .clipped()
                                        .background(Color.black.opacity(0.2))
                                        .clipShape(Circle())
                                        .padding(-5)
                                        .frame(width: prop.isLandscape ? 14 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20), alignment: .center)
                                case .failure:
                                    Image(systemName: "person.fill")
                                        .padding(2)
                                        .font(.system(size:  prop.isLandscape ? 22 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20)))
                                        .cornerRadius(50)
                                        .background(Color.white)
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .frame(width: prop.isLandscape ? 14 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20), alignment: .center)
                                @unknown default:
                                    fatalError()
                                }
                            }
                        }
                    }
                }
            }
    }
    func gradientView(prop:Properties, gradient: Color) -> some View {
        gradient
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: prop.isLandscape ? 10 : 1)
    }
    func btnBackView(prop:Properties, title: String)->some View {
        HStack {
            Image(systemName: "line.3.horizontal.decrease") // set image here
                .font(.custom("Bayon", size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 : 18, relativeTo: .largeTitle))
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue)
                .padding(.bottom,prop.isiPhoneS ? 2 : prop.isiPhoneM ? 3 : prop.isiPhoneL ? 4 : 5)
            Text(title)
                .font(.custom("Bayon", size: prop.isiPhoneS ? 15 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 : 20, relativeTo: .body))
                .foregroundColor(Color("Blue"))
        }
    }
    func backButtonView(prop:Properties, barTitle: String) -> some View {
        HStack {
            Image(systemName: "chevron.backward") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color("Blue"))
            Text(barTitle)
                .font(.custom("Bayon", size: prop.isiPhoneS ? 14 : prop.isiPhoneM ? 16 : prop.isiPhoneL ? 18 : 20, relativeTo: .body))
        }
    }
    func progressingView(prop:Properties) -> some View {
        ZStack{
            Rectangle()
                .fill(.white)
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(20)
            VStack{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(prop.isiPhoneS ? 1 : prop.isiPhoneM ? 1: prop.isiPhoneL ? 1 : 1)
                Text("កំពុងភ្ជាប់")
                    .foregroundColor(.blue)
            }
        }
           
    }
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
    @ViewBuilder func padOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
    func applyBG()-> some View{
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("BG")
            )
    }
    
    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity,alignment: .center)
    }
    
    func setBG() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BG"))
    }
    func setBackgroundRow(color: String, prop: Properties) -> some View {
        self
            .padding(prop.isiPhoneS ? 12 : prop.isiPhoneM ? 15 : prop.isiPhoneL ? 16 :  20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(Color(color))
            .cornerRadius(20)
    }
    
    func backgroundRemover()-> some View {
        self
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .frame(maxHeight: .infinity, alignment: .leading)
    }
    
    func stuName(width: CGFloat)-> some View {
        self
        
    }
    
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
            .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}

