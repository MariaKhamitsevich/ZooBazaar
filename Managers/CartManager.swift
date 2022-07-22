//
//  CartManager.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 25.05.22.
//

import UIKit

final class CartManager {
    
    private(set) var cartProducts: [ProductSettable] = []
    
    static var shared = CartManager()
    
    private init() {}
    
    func productCount() -> Int {
        cartProducts.count
    }
    
    func getProduct(indexPath: IndexPath) -> ProductSettable {
        cartProducts[indexPath.row]
    }
    
    func addProduct(product: ProductSettable) {
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
    
    func deleteProduct(product: ProductSettable) {
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
    
    func decreaseAmount(product: ProductSettable) {
        for i in 0...(cartProducts.count - 1) {
            if product.productID == cartProducts[i].productID {
                if cartProducts[i].productAmount != 1 {
                    cartProducts[i].productAmount -= 1
                    return
                }
            }
        }
    }
    
    func increaseAmount(product: ProductSettable) {
        for i in 0...(cartProducts.count - 1) {
            if product.productID == cartProducts[i].productID {
                cartProducts[i].productAmount += 1
                return
            }
        }
    }
    
    func countTotalPrice() -> Double {
        var totalPrice = 0.0
        
        for product in cartProducts {
            totalPrice += product.totalCost
        }
        
        return totalPrice
    }
    
    func cleanCart() {
        cartProducts.removeAll()
    }
}

