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
    func imageStuBG(width: CGFloat)->some View{
        Image("DashboadBg")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: width)
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
            .frame(maxWidth:prop.isiPhoneS ? 100 : prop.isiPhoneM ? 120 : prop.isiPhoneL ? 130 : 140)
    }
    func LogoGoglobal(prop:Properties)->some View {
        Image("GoGlobalSchool")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth:prop.isiPhoneS ? 120 : prop.isiPhoneM ? 130 : prop.isiPhoneL ? 140 : 150)

    }
    func ImageBackgroundSignIn()->some View{
        Image("Background")
            .resizable()
            .ignoresSafeArea()
    }
    func toolbarView(prop:Properties, barTitle: String)->some View {
        self
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack{
                        Image(systemName: "line.3.horizontal.decrease")
                        Text(barTitle)
                            .font(.custom("Bayon", size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20, relativeTo: .largeTitle))
                    }
                    .foregroundColor(Color("Blue"))
                    .padding(.top, prop.isLandscape ? 10 : 0)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack{
                        Image("user7")
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .frame(width: prop.isLandscape ? 30 : (prop.isiPhoneS ? 24 : prop.isiPhoneM ? 26 : 28), alignment: .center)
                    }
//                    .padding(.top, prop.isLandscape ? 10 : 0)
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
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue)
            Text(title)
                .font(.custom("Bayon", size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20, relativeTo: .largeTitle))
                .foregroundColor(Color("Blue"))
        }
        .padding(.top, prop.isLandscape ? 10 : 0)
    }
    func backButtonView(prop:Properties, barTitle: String) -> some View {
        HStack {
            Image(systemName: "chevron.backward") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color("Blue"))
            Text(barTitle)
                .font(.custom("Bayon", size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20, relativeTo: .largeTitle))
        }
    }
    func progressingView(prop:Properties) -> some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .scaleEffect(prop.isiPhoneS ? 2 : prop.isiPhoneM ? 2.5:3)
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
    func setBackgroundRow(color: String) -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(Color(color))
            .cornerRadius(20)
    }
    
    func backgroundRemover()-> some View {
        self
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
    }
    
    func stuName(width: CGFloat)-> some View {
        self
            
    }
    func widgetStu(ImageStudent: String, Firstname: String, Lastname: String,prop:Properties) -> some View {
        
        VStack(alignment: .center, spacing: 0){
            AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(ImageStudent)"), scale: 2){image in
                
                switch  image {
                    
                case .empty:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .success(let image):
                    image
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Text("Failed fetching image. Make sure to check your data connection and try again.")
                        .foregroundColor(.red)
                @unknown default:
                    fatalError()
                }
            }
           
            HStack{
                Text(Lastname)
                Text(Firstname)
            }
            .padding(5)
            .font(.system(size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 :16))
            .frame(maxWidth: prop.isiPhoneS ? 100 : prop.isiPhoneM ? 110 : prop.isiPhoneL ? 120 : 130)
            .background(.blue)
            .cornerRadius(5)
            .padding(.bottom, 10)
        }
        .background(.clear)
        .foregroundColor(.white)
        .frame(width: prop.isiPhoneS ? 140 : prop.isiPhoneM ? 160 : prop.isiPhoneL ? 180 : 200, height: prop.isiPhoneS ? 160 : prop.isiPhoneM ? 180 : prop.isiPhoneL ? 220 : 220, alignment: .center)
        .addBorder(.orange,width: 1, cornerRadius: 20)
    }
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
             let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
             return clipShape(roundedRect)
                  .overlay(roundedRect.strokeBorder(content, lineWidth: width))
        }
    //binding show variable...
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>,@ViewBuilder sheetView: @escaping ()-> SheetView, onEnd: @escaping () -> ())-> some View {
        return self
            .background(
                HalfSheetHelper(sheetView: sheetView(),showSheet: showSheet, onEnd: onEnd)
            )
    }
}

