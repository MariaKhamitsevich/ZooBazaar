//
//  OrderSender.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 15.07.22.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class OrderSender {
    
    private let products: [Product]
    
    init(products: [Product]) {
        self.products = products
    }
    
    func sentOrder(delivaryMethod: String, totalCost: Double, errorCompletion: (() -> Void)? = nil, successCompletion: (() -> Void)? = nil) {
        let date = Date()
        let calendar = NSCalendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let nanosecond = calendar.component(.nanosecond, from: date)
        let millisecond = nanosecond / 1000000
        var productsDictionary: [String : Any] = [:]
        
        let currentData = "\(year).\(month).\(day).\(hour).\(minutes).\(seconds).\(millisecond)"
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yy"
        let stringDate = dateFormater.string(from: date)
        
        let user = Auth.auth().currentUser
        if let uid = user?.uid {
            let db = Firestore.firestore()
            
            for product in products {
                productsDictionary["\(product.productName)"] = [
                    "productName" : product.productName,
                    "productDescription": product.productDescription,
                    "productImageURL" : product.productImageURL ?? "",
                    "productPrice" : product.productPrice,
                    "isPopular" : product.isPopular,
                    "productID" : product.productID,
                    "productAmount" : product.productAmount]
            }
            
            db.collection("UsersOrders").document(uid).collection("Orders").document(currentData).setData(
                ["TotalCost" : totalCost,
                 "CurrentDate" : stringDate,
                 "deliveryMethod" : delivaryMethod,
                 "Products" : productsDictionary
                ]) { error in
                    if let error = error {
                        errorCompletion?()
                        Swift.debugPrint(error.localizedDescription)
                    } else {
                        successCompletion?()
                    }
                }
        }
}
}
