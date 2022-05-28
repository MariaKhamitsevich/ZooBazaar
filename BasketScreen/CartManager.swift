//
//  CartManager.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 25.05.22.
//

import UIKit

class CartManager {
    
    private var cartProducts: [Product] = []
    
    static var shared = CartManager()
    
    private init() {}
    
    func productCount() -> Int {
        cartProducts.count
    }
    func getProduct(indexPath: IndexPath) -> Product {
        cartProducts[indexPath.row]
    }
    
    func addProduct(product: Product) {
        cartProducts.append(product)
    }
    
    func deleteProduct(product: Product) {
        if !cartProducts.isEmpty {
            for i in 0...(cartProducts.count - 1) {
                if cartProducts[i] == product {
                    cartProducts.remove(at: i)
                }
            }
        }
    }
}

var cartManager = CartManager.shared
