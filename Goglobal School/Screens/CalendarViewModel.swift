//
//  Calendar.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI

struct CalendarViewModel: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var academiclist: ListViewModel = ListViewModel()
    @State var colorBlue: String = "LightBlue"
    @State var colorOrg: String = "LightOrange"
    @State var userProfileImg: String
    @State var refreshing: Bool = false
    @State var axcessPadding: CGFloat = 0
    @State var viewLoading: Bool = false
    @State var hidingDivider: Bool = false
    @State var reloadimgtoolbar: Bool = false
    @Binding var isLoading: Bool
    @Binding var bindingLanguage: String
    let gradient = Color("BG")
    var language: String
    var prop: Properties
    var activeYear: String
    var body: some View {
        NavigationView{
            VStack(spacing: 0) {
                if academiclist.academicYear.isEmpty{
                    ZStack{
                        if viewLoading{
                            progressingView(prop: prop, language: self.language, colorScheme: colorScheme)
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
                }else if academiclist.Error{
                    Text("សូមព្យាយាមម្តងទៀត".localizedLanguage(language: self.language))
                        .foregroundColor(.blue)
                }else{
                    Divider()
                        .opacity(hidingDivider ? 0:1)
                    if refreshing {
                        Spacer()
                        progressingView(prop: prop, language: self.language, colorScheme: colorScheme)
                        Spacer()
                    }else{
                        ScrollRefreshable(langauge: self.language, title: "កំពុងភ្ជាប់", tintColor: .blue){
                            mainView()
                                .padding(.bottom, prop.isiPhoneS ? 65 : prop.isiPhoneM ? 75 : prop.isiPhoneL ? 85 : 100)
                                .padding(.top)
                                .padding(.horizontal, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                                .navigationBarTitleDisplayMode(.inline)
                                .toolbar{
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        HStack{
                                            Image(systemName: "line.3.horizontal.decrease")
                                                .padding(.bottom, prop.isiPhoneS ? 3 : prop.isiPhoneM ? 4 : prop.isiPhoneL ? 5 : 5)
                                            Text("ប្រតិទិនសិក្សា".localizedLanguage(language: language))
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
                                        } else {
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
                        .refreshable {
                            do {
                                academiclist.clearCache()
                                // Sleep for 2 seconds
                                try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
                            } catch {}
                            self.hidingDivider = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.hidingDivider = false
                            }
                            refreshingView()
                            academiclist.populateAllContinent(academicYearId: activeYear)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .onAppear {
                academiclist.populateAllContinent(academicYearId: activeYear)
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
            .applyBG(colorScheme: colorScheme)
        }
        .phoneOnlyStackNavigationView()
        .padOnlyStackNavigationView()
    }
    @ViewBuilder
    private func mainView()-> some View{
        VStack(spacing: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 18){
            HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                graduatedLogo(colorScheme: colorScheme)
                VStack(alignment: .leading){
                    Text("ឆ្នាំសិក្សា ២០២១~២០២២".localizedLanguage(language: self.language))
                        .font(.custom("Bayon", size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20, relativeTo: .largeTitle))
                }
            }
            .foregroundColor(Color("ColorTitle"))
            .setBackgroundRow(color: colorScheme == .dark ? "Black" : colorBlue, prop: prop)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color("ColorTitle"), lineWidth: colorScheme == .dark ? 1 : 0)
            )
            HStack{
                Text("ខែ កញ្ញា ឆ្នាំ ២០២២".localizedLanguage(language: self.language))
                    .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 15))
                Rectangle()
                    .frame(maxHeight: 1)
            }
            .foregroundColor(Color("ColorTitle"))
            .hLeading()
            ForEach(Array(academiclist.sortedAcademicYear.enumerated()), id: \.element.code){ index,academic in
                datingEditer(inputCode: academic.date,inputAnotherDate: academic.enddate, EventName: academic.eventnameKhmer, index: index, Englishname: academic.eventname)
                
            }
        }
    }
    func refreshingView(){
        self.refreshing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshing = false
        }
    }
    func datingEditer(inputCode: String, inputAnotherDate: String, EventName: String, index: Int, Englishname: String) -> some View {
        language == "en" ?
        ForEach(Array(academiclist.convertDateFormatToEnglish(inputDate: inputCode,inputAnotherDate: inputAnotherDate).enumerated()), id: \.element.self){ dex, id in
            HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                graduatedLogo(colorScheme: colorScheme)
                VStack(alignment: .leading){
                    Text(id)
                        .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 15, relativeTo: .body))
                        .listRowBackground(Color.yellow)
                    Text(Englishname)
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 15, relativeTo: .body))
                        .listRowBackground(Color.yellow)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .foregroundColor(((index % 2 == 0) == (dex % 2 == 0)) ? Color("bodyOrange") : Color("bodyBlue") )
            .setBackgroundRow(color: colorScheme == .dark ? "Black" : ((index % 2 == 0) == (dex % 2 == 0)) ? colorOrg : colorBlue, prop: prop)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.orange, lineWidth: colorScheme == .dark ? 1 : 0)
            )
        }
        
        :
        ForEach(Array(academiclist.convertDateFormat(inputDate: inputCode,inputAnotherDate: inputAnotherDate).enumerated()), id: \.element.self){ dex, id in
            HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                graduatedLogo(colorScheme: colorScheme)
                VStack(alignment: .leading){
                    Text(id)
                        .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 15, relativeTo: .body))
                        .listRowBackground(Color.yellow)
                    Text(EventName)
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 15, relativeTo: .body))
                        .listRowBackground(Color.yellow)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .foregroundColor(((index % 2 == 0) == (dex % 2 == 0)) ? Color("bodyOrange") : Color("bodyBlue") )
            .setBackgroundRow(color: colorScheme == .dark ? "Black" : ((index % 2 == 0) == (dex % 2 == 0)) ? colorOrg : colorBlue, prop: prop)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.orange, lineWidth: colorScheme == .dark ? 1 : 0)
            )
        }
    }
    @ViewBuilder
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

struct CalendarViewModel_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        CalendarViewModel(userProfileImg: "", isLoading: .constant(false), bindingLanguage: .constant(""), language: "em", prop: prop, activeYear: "")
    }
}

