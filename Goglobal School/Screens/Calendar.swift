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
    let gradient = Color("BG")
    var prop: Properties
    @State var axcessPadding: CGFloat = 0
    var body: some View {
        NavigationView{
            VStack{
                if academiclist.academicYear.isEmpty{
                    progressingView(prop: prop)
                }else{
                    VStack(spacing: 0){
                        Divider()
                        ScrollView{
                            HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                                graduatedLogo()
                                VStack(alignment: .leading){
                                    Text("ឆ្នាំសិក្សា ២០២១~២០២២")
                                        .font(.custom("Bayon", size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20, relativeTo: .largeTitle))
                                }
                            }
                            .foregroundColor(Color("ColorTitle"))
                            .setBackgroundRow(color: colorBlue)
                            HStack{
                                Text("ខែ កញ្ញា ឆ្នាំ ២០២២")
                                    .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 15))
                                Rectangle()
                                    .frame(maxHeight: 1)
                            }
                            .foregroundColor(Color("ColorTitle"))
                            .hLeading()
                            VStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                                ForEach(Array(academiclist.academicYear.enumerated()), id: \.element.code){ index, academic in
                                    HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                                        graduatedLogo()
                                        VStack(alignment: .leading){
                                            datingEditer(inputCode: academic.date)
                                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 15, relativeTo: .body))
                                                .listRowBackground(Color.yellow)
                                            Text(academic.eventnameKhmer)
                                                .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 15, relativeTo: .body))
                                                .listRowBackground(Color.yellow)
                                        }
                                    }
                                    .foregroundColor(index % 2 == 0 ?
                                                     Color("bodyOrange") : Color("bodyBlue") )
                                    .setBackgroundRow(color: index % 2 == 0 ? colorOrg : colorBlue)
                                }
                            }
                        }
                        .padding(.top)
                        .padding(.horizontal)
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarView(prop: prop, barTitle: "ប្រតិទិនសិក្សា")
                }
            }
            .applyBG()
            .onAppear {
                academiclist.populateAllContinent()
            }
        }
        .phoneOnlyStackNavigationView()
        .padOnlyStackNavigationView()
    }
    func datingEditer(inputCode: String) -> some View {
        Text(academiclist.convertDateFormat(inputDate: inputCode))
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Calendar(prop: prop)
    }
}

