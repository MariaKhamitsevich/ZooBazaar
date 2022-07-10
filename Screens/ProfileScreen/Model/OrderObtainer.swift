//
//  OrderObtainer.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 2.07.22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore

class OrderModel {
    
    var totalCost: Double
    var currentDate: String
    var deliveryMethod: String
    var products: [Product] = []
    
    init(totalCost: Double = 0, currentDate: String = "", deliveryMethod: String = "", products: [Product] = []) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        self.totalCost = totalCost
        self.currentDate = currentDate
        self.deliveryMethod = deliveryMethod
        self.products = products
        self.dateFromString = dateFormatter.date(from: self.currentDate) ?? Date()
    }
    
    var dateFromString: Date
        
    
}

class OrderObtainer {
    var parsedProducts: [OrderModel] = []
    var callBack: (() -> Void)?
    
    init(callBack: (() -> Void)? = nil) {
        self.callBack = callBack
        loadData()
    }
    
    func loadData() {
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        
        let queue = DispatchQueue(label: "com.ZooBazaar.OrderObtainer", qos: .userInteractive)
        
        queue.async {
            if let uid = user?.uid {
                db.collection("UsersOrders").document(uid).collection("Orders").getDocuments{ [weak self] (snapshot, error) in
                    
                    if let error = error {
                        Swift.debugPrint(error.localizedDescription)
                    } else if let snapshot = snapshot {
                        for document in snapshot.documents {
                            let orderModel = OrderModel()
                            orderModel.totalCost = document.get("TotalCost") as? Double ?? 0
                            orderModel.deliveryMethod = document.get("deliveryMethod") as? String ?? ""
                            orderModel.currentDate = document.get("CurrentDate") as? String ?? ""
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd.MM.yy"
                            orderModel.dateFromString = dateFormatter.date(from: orderModel.currentDate) ?? Date()
                            
                            let productDictionary = document.get("Products") as? [String : [String : Any]]
                            
                            if let productDictionary = productDictionary {
                                for value in productDictionary.values {
                                    if let product = self?.transform(value: value) {
                                        orderModel.products.append(product)
                                    }
                                }
                            }
                            self?.parsedProducts.append(orderModel)
                        }
                    }
                }
            }
        }
    }
    
    
    func transform(value: [String : Any]) -> Product {
        var product = Product()
        
        product.productName = value["productName"] as? String ?? ""
        product.productDescription = value["productDescription"] as? String ?? ""
        product.productImageURL = value["productImageURL"] as? String ?? ""
        product.productPrice = value["productPrice"] as? Double ?? 0
        product.isPopular = value["isPopular"] as? Bool ?? false
        product.productID = value["productID"] as? Int ?? 0
        product.productAmount = value["productAmount"] as? Int ?? 1
        
        return product
    }
}
