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
        orderObtainer.parsedProducts.count
    }
    
    func headerInSection(numberOfSection section: Int) -> String {
        "\(orderObtainer.parsedProducts[section].currentDate)\n\(orderObtainer.parsedProducts[section].totalCost) BYN"
    }
    
    func numberOfRowsInSection(numberOfSection section: Int) -> Int {
        orderObtainer.parsedProducts[section].products.count
    }
    
    func getProduct(numberOfSection IndexPath: IndexPath) -> Product {
        orderObtainer.parsedProducts[IndexPath.section].products[IndexPath.row]
    }
}
