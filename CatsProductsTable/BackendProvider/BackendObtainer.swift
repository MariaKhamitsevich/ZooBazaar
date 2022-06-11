//
//  BackendObtainer.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import Foundation

struct BackendObtainer {
    private let data: BackendData
    
    init(data: BackendData) {
        self.data = data
    }
    
    func obtainPet() -> Pet {
        var products: [ProductsForPets] = []
        
        for data in data.backendData {
            let product = ProductsForPets(title: data.brendName, products: data.brendProducts.compactMap{transformProduct(brandProduct: $0)})
            products.append(product)
        }
        return Pet(pet: data.pet, products: products)
    }
    
    func obtainPopularProducts() -> [Product] {
        var products: [ProductsForPets] = []
        
        for data in data.backendData {
            let product = ProductsForPets(title: data.brendName, products: data.brendProducts.compactMap{transformProduct(brandProduct: $0)})
            products.append(product)
        }
        let popularProducts = products.flatMap {$0.products.filter { $0.isPopular}}
        return popularProducts
    }
    
    private func transformProduct(brandProduct: BrandProducts) -> Product {
        Product(
            name: brandProduct.productName,
            description: brandProduct.productDescription,
            image: brandProduct.productImage,
            price: brandProduct.productPrice,
            isPopular: brandProduct.isPopular,
            productID: String(brandProduct.productID))
        
    }
}


// map возвращает новый массив, где каждый эелемент - это элемент старого массива, над которым проделано действие замыкания
// compactMap - то же самое, но исключает nil варианты     В нашем случае лучший вариант, так как исключает те вариантры, для которых не нужны ячейки (в случае ошибки)
// filterMap - то же самое, но обязаетльно возвращает одномерный массив, даже если изначальный массив был "массив массивов" :
//            let array = [[1, 2, 3], [1, 2, 3], [1, 2, 3]]
//            let filterArray = array.filterMap{ $0 }
//            filterArray - [1, 2, 3, 1, 2, 3, 1, 2, 3]
