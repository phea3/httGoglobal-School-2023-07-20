//
//  ApproveView.swift
//  Goglobal School
//
//  Created by loun sokphea on 19/7/23.
//

import SwiftUI
import ActivityIndicatorView

struct ApproveView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var DummyBoolean: Bool = false
    @State var axcessPadding: CGFloat = 0
    @State var currentProgress: CGFloat = 0.0
    @State var userProfileImg: String
    @State var refreshing: Bool  = false
    @State var viewLoading: Bool = false
    @State var hidingDivider: Bool = false
    @State var onAppearImg: Bool = false
    @State private var reloadingImg: Bool = false
    @State var reloadimgtoolbar: Bool = false
    @Binding var isLoading: Bool
    @Binding var bindingLanguage: String
    
    var arr = ["hello"]
    let gradient = Color("BG")
    var parentId: String
    var language: String
    var prop: Properties
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        backButtonView(language: self.language, prop: prop, barTitle: "barTitle")
    }
    }
    var body: some View {
        VStack(spacing: 0) {
            if arr.isEmpty{
                ZStack{
                    if viewLoading{
                        progressingView(prop: prop,language: self.language, colorScheme: colorScheme)
                    }else{
                        Text("មិនមានទិន្ន័យ!".localizedLanguage(language: self.language))
                            .foregroundColor(.blue)
                    }
                }
                .onAppear{
                    self.viewLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.viewLoading = false
                    }
                }
            }else if arr.isEmpty{
                Text("សូមព្យាយាមម្តងទៀត".localizedLanguage(language: self.language))
                    .foregroundColor(.blue)
            }else{
                Divider()
                    .opacity(hidingDivider ? 0:1)
                if !refreshing{
                    ZStack{
                        ScrollRefreshable(langauge: self.language,title: "កំពុងភ្ជាប់", tintColor: .blue) {
                            mainView()
                                .padding(.bottom, prop.isiPhoneS ? 65 : prop.isiPhoneM ? 75 : prop.isiPhoneL ? 85 : 100)
                                .padding(.horizontal, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarTrailing) {
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
                                                            ActivityIndicatorView(isVisible: .constant(true), type: .flickeringDots(count: 8)
                                                            )
                                                                .foregroundColor(.blue)
                                                                .frame(width: prop.isLandscape ? 30 : (prop.isiPhoneS ? 24 : prop.isiPhoneM ? 24 : 24), height:  prop.isLandscape ? 30 : (prop.isiPhoneS ? 24 : prop.isiPhoneM ? 24 : 24), alignment: .center)
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
                                                            ActivityIndicatorView(isVisible: .constant(true), type: .flickeringDots(count: 8)
                                                            )
                                                                .foregroundColor(.blue)
                                                                .frame(width: prop.isLandscape ? 30 : (prop.isiPhoneS ? 24 : prop.isiPhoneM ? 24 : 24), height:  prop.isLandscape ? 30 : (prop.isiPhoneS ? 24 : prop.isiPhoneM ? 24 : 24), alignment: .center)
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
                        .refreshable {
                            do {
                                // Sleep for 2 seconds
                                try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
                            } catch {}
                            self.hidingDivider = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.hidingDivider = false
                            }
                            refreshingView()
                        }
                        if onAppearImg{
                            ZStack{
                                Color(colorScheme == .dark ? "Black" : "BG")
                                    .frame(maxWidth:.infinity, maxHeight: .infinity)
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
                                        }
                                    Spacer()
                                }
                                
                            }
                            
                        }
                    }
                }else{
                    Spacer()
                    progressingView(prop: prop, language: self.language, colorScheme: colorScheme)
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .onAppear {
        }
        .setBG(colorScheme: colorScheme)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
        
    }
    func refreshingView(){
        self.refreshing = true
        self.onAppearImg = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshing = false
        }
    }
    
    @ViewBuilder
    private func mainView()-> some View{
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0){
                Text("hello")
            }
        }
    }
    @ViewBuilder
    private func ChangeLanguage()-> some View {
        HStack{
            Menu {
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

