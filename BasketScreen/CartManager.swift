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
    
    func checkProductAmount(product: Product) -> Int {
        guard !cartProducts.isEmpty
        else {
            return 0
        }
        for i in 0...(cartProducts.count - 1) {
            if product.productID == cartProducts[i].productID {
                return cartProducts[i].productAmount
            }
        }
        return 0
    }
    func addProduct(product: Product) {
        guard !cartProducts.isEmpty
        else {
            cartProducts.append(product)
            return
        }
       
            for i in 0...(cartProducts.count - 1) {                
                if product.productID == cartProducts[i].productID {
                    cartProducts[i].productAmount += 1
                    return
                }
            }
        cartProducts.append(product)
       
    }
    
    func deleteProduct(product: Product) {
        if !cartProducts.isEmpty {
            let count = cartProducts.count
            var products = cartProducts
            
            for i in 0...(count - 1) {
                if cartProducts[i].productID == product.productID {
                    products.remove(at: i)
                }
            }
            
            cartProducts = products
        }
    }
    
    func decreaseAmount(product: Product) {
        for i in 0...(cartProducts.count - 1) {
            if product.productID == cartProducts[i].productID {
                if cartProducts[i].productAmount != 1 {
                    cartProducts[i].productAmount -= 1
                    return
                }
            }
        }
    }
    
    func increaseAmount(product: Product) {
        for i in 0...(cartProducts.count - 1) {
            if product.productID == cartProducts[i].productID {
                cartProducts[i].productAmount += 1
                return
            }
        }
    }
}

