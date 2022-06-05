//
//  Products.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 11.05.22.
//

import UIKit

//protocol ProductsForPets {
//    var title: String {get}
//    var products: [Product] {get}
//}

struct Pet {
  
    var pet: Pets
    var products: [ProductsForPets]
    
}


struct ProductsForPets {
    var title: String
    var products: [Product]
}

struct Product {
    
    
    let name: String
    let description: String
    let image: UIImage!
    let price: String
    var isPopular: Bool
    var priceForKg: String {
        get {
            "\(price) рублей за кг"
        }
    }
    
    let productID: String
    var productAmount = 1
}
