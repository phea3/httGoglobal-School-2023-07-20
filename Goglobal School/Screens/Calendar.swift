//
//  Calendar.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI

struct Calendar: View {
    
    @StateObject var academiclist: ListViewModel = ListViewModel()
    @State var colorBlue: String = "LightBlue"
    @State var colorOrg: String = "LightOrange"
    @State var userProfileImg: String
    @State var refreshing: Bool = false
    @State var axcessPadding: CGFloat = 0
    @State var viewLoading: Bool = false
    @State var hidingDivider: Bool = false
    @Binding var isLoading: Bool
    let gradient = Color("BG")
    var prop: Properties
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0) {
                if academiclist.academicYear.isEmpty{
                    ZStack{
                        if viewLoading{
                            progressingView(prop: prop)
                        }else{
                            Text("មិនមានទិន្ន័យ!")
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
                    Text("សូមព្យាយាមម្តងទៀត")
                        .foregroundColor(.blue)
                }else{
                    Divider()
                        .opacity(hidingDivider ? 0:1)
                    if refreshing {
                        Spacer()
                        progressingView(prop: prop)
                        Spacer()
                    }else{
                        ScrollRefreshable(title: "កំពុងភ្ជាប់", tintColor: .blue){
                            mainView()
                                .navigationBarTitleDisplayMode(.inline)
                                .padding(.bottom, prop.isiPhoneS ? 65 : prop.isiPhoneM ? 75 : prop.isiPhoneL ? 85 : 100)
                                .padding(.top)
                                .padding(.horizontal, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                                .toolbarView(prop: prop, barTitle: "ប្រតិទិនសិក្សា", profileImg: userProfileImg)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .onAppear {
                academiclist.populateAllContinent()
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
            .applyBG()
        }
        .phoneOnlyStackNavigationView()
        .padOnlyStackNavigationView()
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
            academiclist.populateAllContinent()
        }
    }
    @ViewBuilder
    private func mainView()-> some View{
        VStack(spacing: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 18){
            HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                graduatedLogo()
                VStack(alignment: .leading){
                    Text("ឆ្នាំសិក្សា ២០២១~២០២២")
                        .font(.custom("Bayon", size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20, relativeTo: .largeTitle))
                }
            }
            .foregroundColor(Color("ColorTitle"))
            .setBackgroundRow(color: colorBlue, prop: prop)
            HStack{
                Text("ខែ កញ្ញា ឆ្នាំ ២០២២")
                    .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 15))
                Rectangle()
                    .frame(maxHeight: 1)
            }
            .foregroundColor(Color("ColorTitle"))
            .hLeading()
            ForEach(Array(academiclist.academicYear.enumerated()), id: \.element.code){ index, academic in
                HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                    graduatedLogo()
                    VStack(alignment: .leading){
                        datingEditer(inputCode: academic.date)
                            .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 15, relativeTo: .body))
                            .listRowBackground(Color.yellow)
                        Text(academic.eventnameKhmer)
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 15, relativeTo: .body))
                            .listRowBackground(Color.yellow)
                    }
                }
                .foregroundColor(index % 2 == 0 ?
                                 Color("bodyOrange") : Color("bodyBlue") )
                .setBackgroundRow(color: index % 2 == 0 ? colorOrg : colorBlue, prop: prop)
                .frame(height: prop.isiPhoneM ? 80 : .infinity)
            }
        }
    }
    func refreshingView(){
        self.refreshing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshing = false
        }
    }
    func datingEditer(inputCode: String) -> some View {
        Text(academiclist.convertDateFormat(inputDate: inputCode))
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Calendar(userProfileImg: "", isLoading: .constant(false), prop: prop)
    }
}

