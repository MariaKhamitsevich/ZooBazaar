//
//  TestBackend.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 25.06.22.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage


struct TestPet {
    let pet: Pets
    var backendData: [TestBackendProducts]
}

struct TestBackendProducts {
    var brendName: String
    var brendProducts: [TestBrandProducts]
    
    init(brendName: String = "", brendProducts: [TestBrandProducts] = []) {
        self.brendName = brendName
        self.brendProducts = brendProducts
    }
}

struct TestBrandProducts {
    var productName: String
    var productDescription: String
    var productImageURL: String
    var productPrice: Double
    var priceForKg: String {
        get {
            "\(productPrice) рублей за кг"
        }
    }
    var totalCost: Double {
        productPrice * Double(productAmount)
    }
    var isPopular: Bool
    var productID: Int
    var productAmount = 1
    
    init(productName: String = "", productDescription: String = "", productImageURL: String = "", productPrice: Double = 0, isPopular: Bool = false, productID: Int = 0) {
        self.productName = productName
        self.productDescription = productDescription
        self.productImageURL = productImageURL
        self.productPrice = productPrice
        self.isPopular = isPopular
        self.productID = productID
    }
    
    static func parseBrandProduct(productQuery: QueryDocumentSnapshot) -> TestBrandProducts {
        var product = TestBrandProducts()
        product.productName = productQuery.get("productName") as? String ?? ""
        product.productDescription = productQuery.get("productDescription") as? String ?? ""
        product.productImageURL = productQuery.get("productImage") as? String ?? ""
        product.productPrice = productQuery.get("productPrice") as? Double ?? 0
        product.isPopular = productQuery.get("isPopular") as? Bool ?? false
        product.productID = productQuery.get("productID") as? Int ?? 0
        
        return product
    }
}


