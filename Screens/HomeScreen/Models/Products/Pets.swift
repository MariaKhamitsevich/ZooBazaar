//
//  Products.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 11.05.22.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseStorageUI


protocol ProductSettable {
    var productName: String { get }
    var productDescription: String { get }
    var productImageURL: String! { get }
    var productPrice: Double { get }
    var isPopular: Bool { get }
    var priceForKg: String { get }
    var totalCost: Double { get }
    var productID: Int { get }
    var productAmount: Int { get set }
}

struct Pet {
    var pet: Pets
    var products: [ProductsForPets]
}


struct ProductsForPets {
    var brendName: String
    var brendProducts: [Product]
}

struct Product: ProductSettable {
    
    var productName: String
    var productDescription: String
    var productImageURL: String!
    var productPrice: Double
    var isPopular: Bool
    var priceForKg: String {
        get {
            "\(productPrice) рублей за кг"
        }
    }
    var totalCost: Double {
        productPrice * Double(productAmount)
    }
    
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
    
    static func parseBrandProduct(productQuery: QueryDocumentSnapshot) -> Product {
        var product = Product()
        product.productName = productQuery.get("productName") as? String ?? ""
        product.productDescription = productQuery.get("productDescription") as? String ?? ""
        product.productImageURL = productQuery.get("productImage") as? String ?? ""
        product.productPrice = productQuery.get("productPrice") as? Double ?? 0
        product.isPopular = productQuery.get("isPopular") as? Bool ?? false
        product.productID = productQuery.get("productID") as? Int ?? 0
        
        return product
    }
    
}


enum Pets: String {
    case cats = "catsBackendData"
    case dogs = "dogsBackendData"
    case rodents = "rodentsBackendData"
}
