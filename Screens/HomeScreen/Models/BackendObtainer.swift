//
//  BackendObtainer.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import UIKit
import FirebaseFirestore

final class BackendObtainer {
    
    var callBack: (() -> Void)?
    
    private var allPets: [Pet] = []
    
    let queue = DispatchQueue(label: "com.Zoobazaar.BackendObtainer", qos: .userInitiated)
    
    init(callBack: (() -> Void)? = nil) {
        self.callBack = callBack
        loadPets()
    }
    
    func obtainPets() -> [Pet] {
        allPets
    }
    
    func obtainPopularProducts() -> [Product] {
        let popularProducts: [Product] = allPets.flatMap {
            $0.products.flatMap {
                $0.brandProducts.filter { $0.isPopular}
            }
        }
        return popularProducts
    }
    
    private func loadPets() {
        let db = Firestore.firestore()
        
        queue.async { [weak self] in
            guard let self = self else {return}
            db.collection("Pets").getDocuments { (snapshot, error) in
                if let error = error {
                    Swift.debugPrint(error.localizedDescription)
                } else if let snapshot = snapshot {
                    
                    
                    for document in snapshot.documents {
                        guard let petRawValue = document.get("pet") as? String,
                              let brandName = document.get("brandName") as? String,
                              let productName = document.get("productName") as? String,
                              let productDescription = document.get("productDescription") as? String,
                              let productImageURL = document.get("productImageURL") as? String,
                              let productPrice = document.get("productPrice") as? Double,
                              let productID = document.get("productID") as? Int
                        else { return }
                        
                        let isPopular = document.get("isPopular") as? Bool ?? false
                       
                        
                        let product = Product(productName: productName, productDescription: productDescription, productImageURL: productImageURL, productPrice: productPrice, isPopular: isPopular, productID: productID)
                        let productForPets = ProductsForPets(brandName: brandName, brandProducts: [product])
                        
                        if let petIndex = self.allPets.firstIndex(where: { $0.pet.rawValue == petRawValue }) {
                            
                            if let productsForPetsIndex = self.allPets[petIndex].products.firstIndex(where: { $0.brandName == brandName }) {
                                
                                self.allPets[petIndex].products[productsForPetsIndex].brandProducts.append(product)
                            } else {
                                self.allPets[petIndex].products.append(productForPets)
                            }
                            
                        } else {
                            self.allPets.append(Pet(pet: Pets(rawValue: petRawValue) ?? .cats, products: [productForPets]))
                        }
                        
                        self.callBack?()
                    }
                    
                }
            }
            
        }
    }
}


// map возвращает новый массив, где каждый эелемент - это элемент старого массива, над которым проделано действие замыкания
// compactMap - то же самое, но исключает nil варианты     В нашем случае лучший вариант, так как исключает те вариантры, для которых не нужны ячейки (в случае ошибки)
// filterMap - то же самое, но обязаетльно возвращает одномерный массив, даже если изначальный массив был "массив массивов" :
//            let array = [[1, 2, 3], [1, 2, 3], [1, 2, 3]]
//            let filterArray = array.filterMap{ $0 }
//            filterArray - [1, 2, 3, 1, 2, 3, 1, 2, 3]
