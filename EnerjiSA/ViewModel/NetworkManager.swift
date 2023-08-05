//
//  NetworkManager.swift
//  EnerjiSA
//
//  Created by Seyhun Koçak on 2.08.2023.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    var totalPriceCount = Int()
    var totalPrice = String()
    var company = [String]()
    var address = [String]()
    var installationNum = [String]()
    var contractNum = [String]()
    var debtAmount = [String]()
    var invoices = [Invoice]()

    var data = [BillData]()

    func fetchData() {
        let url = "https://raw.githubusercontent.com/bydevelopertr/enerjisa/main/userInvoices.json" 

        AF.request(url).validate().responseDecodable(of: BillData.self) { response in
            switch response.result {
            case .success(let model):

                for i in 0..<model.list.count {
                    self.totalPriceCount = model.totalPriceCount
                    self.totalPrice = model.totalPrice
                    self.company.append(model.list[i].company)
                    self.address.append(model.list[i].address)
                    self.installationNum.append(model.list[i].installationNumber)
                    self.contractNum.append(model.list[i].contractAccountNumber)
                    self.debtAmount.append(model.list[i].amount)
                }
                self.invoices = model.invoices

            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}




