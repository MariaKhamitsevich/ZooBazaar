//
//  OrderProvider.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 2.07.22.
//

import Foundation


struct OrderProvider {
    private var orderObtainer = OrderObtainer()
    
    var numberOfSections: Int {
        let products = orderObtainer.parsedProducts.sorted(by: {
            $0.dateFromString.compare($1.dateFromString) == .orderedDescending
        })
        return products.count
    }
    
    func headerInSection(numberOfSection section: Int) -> String {
        let products = orderObtainer.parsedProducts.sorted(by: {
            $0.dateFromString.timeIntervalSince1970 > $1.dateFromString.timeIntervalSince1970
        })
      return "\(products[section].currentDate)\n\(products[section].totalCost) BYN"
    }
    
    func numberOfRowsInSection(numberOfSection section: Int) -> Int {
        let products = orderObtainer.parsedProducts.sorted(by: {
            $0.dateFromString.timeIntervalSince1970 > $1.dateFromString.timeIntervalSince1970
        })
       return products[section].products.count
    }
    
    func getProduct(numberOfSection IndexPath: IndexPath) -> Product {
        let products = orderObtainer.parsedProducts.sorted(by: {
            $0.dateFromString.timeIntervalSince1970 > $1.dateFromString.timeIntervalSince1970
        })
       return products[IndexPath.section].products[IndexPath.row]
    }
}
