//
//  InvoiceViewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 4/10/22.
//

import Foundation

class InvoiceViewModel: ObservableObject{
    @Published var paymentmethod: [invoiceModel] = []
    
    func getInvoice(studentId: String){
        Network.shared.apollo.fetch(query: GetInvoiceBystudentIdWithPaginationQuery(studentId: studentId)){ [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let paymentmethod = graphQLResult.data?.getInvoiceBystudentIdWithPagination.invoices{
                    self?.paymentmethod = paymentmethod.map(invoiceModel.init)
                }
            case .failure(let graphQLError):
                print(graphQLError)
            }
        }
    }
    func convertToExactForm(getDate: String) -> String {
        let isoDate = getDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:isoDate)
        if date != nil{
            let StringFormatter =  DateFormatter()
            StringFormatter.locale = Locale(identifier: "en_US_POSIX")
            StringFormatter.dateFormat = "dd, MM yyyy"
            let string =  StringFormatter.string(from: date ?? Date())
            return string
        }
            return "គ្មានកាលបរិច្ឆេទ"
    }
}
    struct invoiceModel {
        var invoice : GetInvoiceBystudentIdWithPaginationQuery.Data.GetInvoiceBystudentIdWithPagination.Invoice
        
        var Id: String {
            invoice._id
        }
        var Amount: Double {
            invoice.amount ?? 0.0
        }
        var CreateAt: String {
            invoice.createdAt ?? ""
        }
        var InvoiceId: Int {
            invoice.invoiceId ?? 0
        }
        var PaidStatus: Bool {
            invoice.paidStatus ?? false
        }
        var AdditionalFee: [additionalFeeModel]{
            (invoice.additionalFee?.map(additionalFeeModel.init))!
        }
    }
struct additionalFeeModel{
    var additionalFee : GetInvoiceBystudentIdWithPaginationQuery.Data.GetInvoiceBystudentIdWithPagination.Invoice.AdditionalFee?
    
    var Id: String {
        additionalFee?._id ?? ""
    }
    var countMonth: Int{
        additionalFee?.countMonth ?? 0
    }
    var IncomeHead: incomeHeadModel {
        (additionalFee?.incomeHead.map(incomeHeadModel.init))!
    }
}

struct incomeHeadModel{
    var incomeHead : GetInvoiceBystudentIdWithPaginationQuery.Data.GetInvoiceBystudentIdWithPagination.Invoice.AdditionalFee.IncomeHead
    var Id: String {
        incomeHead._id
    }
    var IncomeHead: String {
        incomeHead.incomeHead ?? ""
    }
    
    var Price: Double {
        incomeHead.price ?? 0.0
    }
    var Unit: String {
        incomeHead.unit ?? ""
    }
    var IncomeType: String {
        incomeHead.incomeType ?? ""
    }
    var Note: String {
        incomeHead.note ?? ""
    }
}
