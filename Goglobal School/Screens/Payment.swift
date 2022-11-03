//
//  Payment.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 1/10/22.
//

import SwiftUI

struct Payment: View {
    @StateObject var paymentmethod: InvoiceViewModel = InvoiceViewModel()
    @State var loadingScreen: Bool = false
    @State var currentProgress: CGFloat = 0
    var studentId: String
    var prop: Properties
    var body: some View {
        VStack{
            if loadingScreen{
                ProgressView(value: currentProgress, total: 1000)
                    Spacer()
                    .onAppear{
                        self.currentProgress = 250
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                            self.currentProgress = 500
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            self.currentProgress = 750
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                            self.currentProgress = 1000
                        }
                    }
                   
            }else{
                rowView(dater: "កាលបរិច្ឆេទ", pay: "បង់ថ្លៃ", period: "បរិយាយ", total: "សរុប")
                    .padding()
                ScrollView(.vertical, showsIndicators: false) {
                    if let tasks = paymentmethod.paymentmethod{
                        if tasks.isEmpty{
                            Text("មិនមានការទូទាត់ថ្លៃសិក្សា!!!")
                                .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16))
                                .fontWeight(.light)
                                .offset(y: prop.isLandscape ? 100 :  300)
                        }else{
                            ForEach(paymentmethod.paymentmethod, id: \.Id){ payment in
                                VStack(spacing: 20){
                                    HStack{
                                        HStack{
                                            Image(systemName: "calendar.badge.clock")
                                                .foregroundColor(.blue)
                                            Text(getExactDate(date: payment.CreateAt))
                                                .foregroundColor(.blue)
                                        }
                                        Spacer()
                                        
                                        if payment.NetAmount == 0.0 && payment.GrossAmount == 0.0 && payment.StartDate == "" && payment.EndDate == "" {
                                            VStack{
                                                ForEach(payment.AdditionalFee, id: \.Id) { task in
                                                    HStack{
                                                        Text(task.IncomeHead.IncomeHead)
                                                            .foregroundColor(.blue)
                                                            .fixedSize(horizontal: false, vertical: true)
                                                        Spacer()
                                                        Text("\(task.countMonth) \(task.IncomeHead.Unit)")
                                                            .foregroundColor(.blue)
                                                        Spacer()
                                                        Text("$\(getExactPrice(price: task.Total ))")
                                                            .foregroundColor(.red)
                                                    }
                                                    .padding(5)
//                                                    .overlay(
//                                                        RoundedRectangle(cornerRadius: 5)
//                                                            .stroke(Color.orange, lineWidth: 1)
//                                                    )
                                                    Rectangle()
                                                        .fill(.orange)
                                                        .frame(width: .infinity, height: 1)
                                                }
                                            }
                                           
                                        } else {
                                            VStack{
                                                HStack{
                                                    Text("ថ្លៃសិក្សា/Tuition Fee")
                                                        .foregroundColor(.blue)
                                                    Spacer()
                                                    if !payment.Month.isEmpty{
                                                        Text("1 Month")
                                                           .foregroundColor(.blue)
                                                    } else if !payment.Quarter.isEmpty {
                                                        Text("1 Quarter")
                                                            .foregroundColor(.blue)
                                                    } else if !payment.AcademicTermId.isEmpty {
                                                        Text("1 Semester")
                                                            .foregroundColor(.blue)
                                                    } else {
                                                        Text("1 Year")
                                                            .foregroundColor(.blue)
                                                    }
                                                    Spacer()
                                                    Text("$\(getExactPrice(price: payment.Amount ))")
                                                        .foregroundColor(.red)
                                                }
                                                .padding(5)
//                                                .overlay(
//                                                    RoundedRectangle(cornerRadius: 5)
//                                                        .stroke(Color.orange, lineWidth: 1)
//                                                )
                                                Rectangle()
                                                    .fill(.orange)
                                                    .frame(width: .infinity, height: 1)
                                                
                                                if !payment.AdditionalFee.isEmpty{
                                                   
                                                    ForEach(payment.AdditionalFee, id: \.Id) { task in
                                                        HStack{
                                                            Text(task.IncomeHead.IncomeHead)
                                                                .foregroundColor(.blue)
                                                                .fixedSize(horizontal: false, vertical: true)
                                                            Spacer()
                                                            Text("\(task.countMonth) \(task.IncomeHead.Unit)")
                                                                .foregroundColor(.blue)
                                                            Spacer()
                                                            Text("$\(getExactPrice(price: task.Total ))")
                                                                .foregroundColor(.red)
                                                        }
                                                        .padding(5)
//                                                        .overlay(
//                                                            RoundedRectangle(cornerRadius: 5)
//                                                                .stroke(Color.orange, lineWidth: 1)
//                                                        )
                                                        Rectangle()
                                                            .fill(.orange)
                                                            .frame(width: .infinity, height: 1)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 11 : prop.isiPhoneM ? 13 : 15, relativeTo: .body))
                                    .foregroundColor(.blue)
                                    .padding(.horizontal)
                                    .frame(maxWidth:.infinity)
                                    .background(Color("LightOrange").opacity(0.5))
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                    else{
                        // MARK: Progress View
                        ProgressView()
                            .offset(y: 100)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom,60)
            }
        }
        .setBG()
        .onAppear{
            paymentmethod.getInvoice(studentId: studentId)
            self.loadingScreen = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.loadingScreen = false
            }
        }
    }
    func getExactDate(date: String)-> String{
        paymentmethod.convertToExactForm(getDate: date)
    }
    func getExactPrice(price: Double)-> String{
        String(format: "%.0f", price)
    }
    func rowView(dater: String, pay: String, period: String, total: String)-> some View {
        HStack{
            Text(dater)
            Spacer()
            Text(pay)
            Spacer()
            Text(period)
            Spacer()
            Text(total)
        }
        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 11 : prop.isiPhoneM ? 13 : 15, relativeTo: .body))
        .foregroundColor(.blue)
        .padding()
        .frame(maxWidth:.infinity, maxHeight:50)
        .background(Color("LightBlue"))
        .cornerRadius(10)
        
    }
    func rowdata(dater: String, pay: String, period: String, total: String)-> some View {
        HStack{
            Image(systemName: "calendar.badge.clock")
                .foregroundColor(.blue)
            Text(dater)
                .foregroundColor(.blue)
            Spacer()
            Text(pay)
                .foregroundColor(.blue)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
            Text(period)
                .foregroundColor(.blue)
            Spacer()
            Text(total)
                .foregroundColor(.red)
        }
        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 11 : prop.isiPhoneM ? 13 : 15, relativeTo: .body))
        .foregroundColor(.blue)
        .padding()
        .frame(maxWidth:.infinity)
        .background(Color("LightOrange").opacity(0.5))
        .cornerRadius(10)
        
    }
}

struct Payment_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Payment(studentId: "", prop: prop)
    }
}
