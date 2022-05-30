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
        if !cartProducts.contains(product) {
        cartProducts.append(product)
        }
    }
    
    func deleteProduct(product: Product) {
        if !cartProducts.isEmpty {
            let count = cartProducts.count
            var products = cartProducts
            
            for i in 0...(count - 1) {
                if cartProducts[i] == product {
                    products.remove(at: i)
                }
            }
            
            cartProducts = products
        }
    }
    
    func exapleAdding(product: Product, position: Int = 0) {
        cartProducts.insert(product, at: position)
    }
}

