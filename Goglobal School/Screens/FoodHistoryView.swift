//
//  FoodHistoryView.swift
//  Goglobal School
//
//  Created by Luon Sokphea on 23/12/22.
//

import SwiftUI

struct FoodHistoryView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var loadingScreen: Bool = false
    @State var currentProgress: CGFloat = 0
    @State var currentMonth: Int = 0
    @Binding var currentDate: Date
    var language: String
    var btnBack : some View { Button(action:{self.presentationMode.wrappedValue.dismiss()}) {backButtonView(language: self.language, prop: prop, barTitle: "ប្រវត្តិការបរិភោគអាហារ")}}
    var prop: Properties
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
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
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                            self.currentProgress = 1000
                        }
                    }
                
            }else{
                mainView()
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: btnBack)
                    .navigationBarBackButtonHidden(true)
                    .padding(.bottom,prop.isiPhoneS ? 10 : prop.isiPhoneM ? 15 : prop.isiPhoneL ? 20 : 25)
                    .padding(.horizontal, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .setBG(colorScheme: colorScheme)
        .onAppear(perform: {
            
        })
    }
    private func mainView()-> some View {
        VStack(spacing: 0){
            let days: [String] = ["អាទិត្យ","ចន្ទ","អង្គារ","ពុធ","ព្រហ","សុក្រ","សៅរ៍"]
            let englishdays: [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
            
            HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                VStack(alignment: .leading, spacing: prop.isiPhoneS ? 6 : prop.isiPhoneM ? 8 : 10) {
                    Text(extraDate()[0])
                        .font(.system(size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14))
                        .fontWeight(.semibold)
                    
                    Text(extraDate()[1])
                        .font(.custom("Bayon", size: prop.isiPhoneS ? 36 : prop.isiPhoneM ? 38 : 40, relativeTo: .title))
                }
                Spacer()
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Button {
                    withAnimation {
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding()
            
            // Day View...
            language == "en" ?
                
            HStack(spacing: 0){
                ForEach(englishdays, id: \.self){ day in
                    Text(day)
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .callout).bold())
                        .frame(maxWidth: .infinity)
                        .foregroundColor(day == "Sun" ? .red : .gray)
                }
            }
            
            :
            
            HStack(spacing: 0){
                ForEach(days, id: \.self){ day in
                    Text(day)
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .callout).bold())
                        .frame(maxWidth: .infinity)
                        .foregroundColor(day == "អាទិត្យ" ? .red : .gray)
                }
                
            }
//            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
        }
        .padding(.bottom, 35)
        .onChange(of: currentMonth) { newValue in
            // Update Month...
            currentDate = getCurrentMont()
        }
    }
    // extracting year and month for display...
    func extraDate()->[String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMont()->Date{
        let calendar = NSCalendar.current
        // Getting Current Month Date...
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else{
            return Date()
        }
        return currentMonth
    }
}

struct FoodHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        FoodHistoryView(currentDate: .constant(Date()), language: "", prop: prop)
    }
}
