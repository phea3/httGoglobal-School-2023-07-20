//
//  ViewPermission.swift
//  Goglobal School
//
//  Created by Macmini on 21/4/23.
//

import SwiftUI

struct ViewPermission: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var loadingScreen: Bool = false
    @State var currentProgress: CGFloat = 0
    var shiftName: String
    var reason: String
    var startDate: String
    var endDate: String
    var requestDate: String
    var prop: Properties
    var language: String
    var btnBack : some View { Button(action:{self.presentationMode.wrappedValue.dismiss()}) {backButtonView(language: self.language, prop: prop, barTitle: "សុំច្បាប់")}}
    var body: some View {
        VStack(spacing:0){
            Divider()
            if loadingScreen{
                ProgressView(value: currentProgress, total: 1000)
                Spacer()
                    .onAppear{
                        self.currentProgress = 250
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            self.currentProgress = 500
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9){
                            self.currentProgress = 750
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            self.currentProgress = 1000
                        }
                    }
                
            }else{
                VStack{
                    HStack{
                        Text("ថ្ងៃស្នើសុំសម្រាក".localizedLanguage(language: self.language))
                            .foregroundColor(.gray)
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16, relativeTo: .largeTitle))
                        Spacer()
                        Text(convertStringToDateAndBackToString(inputDate:requestDate))
                            .foregroundColor(.gray)
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16, relativeTo: .largeTitle))
                    }
                    Divider()
                    HStack{
                        Rectangle()
                            .fill(Color("bodyBlue"))
                            .frame(width: 10, height: 80)
                        VStack(alignment: .leading){
                            Text(startDate == endDate ? convertStringToDateAndBackToString(inputDate: startDate) : "\(convertStringToDateAndBackToString(inputDate: startDate)) ~ \(convertStringToDateAndBackToString(inputDate: endDate))")
                                .foregroundColor(.black)
                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18, relativeTo: .largeTitle))
                            Text(shiftName)
                                .foregroundColor(.black)
                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16, relativeTo: .largeTitle))
                        }
                        .padding(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("LightBlue"))
                    Divider()
                    VStack(alignment: .leading){
                        Text("មូលហេតុ".localizedLanguage(language: self.language))
                            .foregroundColor(.gray)
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18, relativeTo: .largeTitle))
                        Text(reason)
                            .foregroundColor(.black)
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16, relativeTo: .largeTitle))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                    VStack(alignment: .leading){
                        Text("ស្ថានភាព".localizedLanguage(language: self.language))
                            .foregroundColor(.gray)
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18, relativeTo: .largeTitle))
                        Text("\(Image(systemName: "checkmark.circle")) ស្នើសុំសម្រាកជោគជ័យ")
                            .foregroundColor(.green)
                            .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16, relativeTo: .largeTitle))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(width: .infinity, height: .infinity)
                .padding()
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .setBG(colorScheme: colorScheme)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            self.loadingScreen = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.loadingScreen = false
            }
        })
    }
    private func convertStringToDateAndBackToString(inputDate: String) -> String{
        let isoDate = inputDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:isoDate) ?? Date()
        let StringFormatter =  DateFormatter()
        StringFormatter.locale = Locale(identifier: "en_US_POSIX")
        StringFormatter.dateFormat = "dd MMM, yyyy"
        let stringed = StringFormatter.string(from: date)
        return stringed
    }
}
