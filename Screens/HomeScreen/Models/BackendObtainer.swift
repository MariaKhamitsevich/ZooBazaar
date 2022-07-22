//
//  BackendObtainer.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import UIKit
import FirebaseFirestore

final class BackendObtainer {
    
    var parsedBackendData: [ProductsForPets] = []
    var callBack: (() -> Void)?
    private let pet: Pets
    
    var allPets: [Pet] = []
    
    let queue = DispatchQueue(label: "com.Zoobazaar.BackendObtainer", qos: .userInitiated)
    
    init(pet: Pets, callBack: (() -> Void)? = nil) {
        self.pet = pet
        self.callBack = callBack
        loadData()
        loadPets()
    }
    
    func obtainPet() -> Pet {
//        Pet(pet: pet, products: self.parsedBackendData)
        allPets.first(where: { $0.pet  == pet }) ?? Pet(pet: .cats, products: [])
    }
    
    func obtainPopularProducts() -> [Product] {
        let popularProducts = parsedBackendData.flatMap {
            $0.brandProducts.filter { $0.isPopular}
        }
        return popularProducts
    }
    
    func obtainAllProducts() -> [Product] {
        let products = parsedBackendData.flatMap({$0.brandProducts})
        return products
    }
    
    private func loadData() {
        
        let db = Firestore.firestore()
        
        queue.async { [weak self] in
            guard let self = self else {return}
            db.collection("BackendData").document(self.pet.rawValue).collection("backendData").getDocuments{ (snapshot, error) in
                if let error = error {
                    Swift.debugPrint(error.localizedDescription)
                } else if let snapshot = snapshot {
                    
                    for document in snapshot.documents {
                        let brandName = document.get("brendName") as? String ?? ""
                        let documentID = document.documentID
                        db.collection("BackendData").document(self.pet.rawValue).collection("backendData").document(documentID).collection("brendProducts").getDocuments {  (snapshot, error) in
                            
                            if let error = error {
                                Swift.debugPrint(error.localizedDescription)
                            } else if let snapshot = snapshot {
                                
                                var brendProducts: [Product] = []
                                
                                for snapshotProduct in snapshot.documents {
                                    let product = Product.parseBrandProduct(productQuery: snapshotProduct)
                                    brendProducts.append(product)
                                }
                                
                                self.parsedBackendData.append(ProductsForPets(brandName: brandName, brandProducts: brendProducts))
                                self.callBack?()
                            }
                        }
                    }
                }
            }
        }
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
                        let petRawValue = document.get("pet") as? String ?? ""
                        let brandName = document.get("brandName") as? String ?? ""
                        let productName = document.get("productName") as? String ?? ""
                        let productDescription = document.get("productDescription") as? String ?? ""
                        let productImageURL = document.get("productImageURL") as? String ?? ""
                        let productPrice = document.get("productPrice") as? Double ?? 0
                        let isPopular = document.get("isPopular") as? Bool ?? false
                        let productID = document.get("productID") as? Int ?? 0
                        
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
                       
                    }
                    
                    self.callBack?()
                }
            }

        }
    }
    
    private func transform(value: [String : Any]) -> Product {
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


// map возвращает новый массив, где каждый эелемент - это элемент старого массива, над которым проделано действие замыкания
// compactMap - то же самое, но исключает nil варианты     В нашем случае лучший вариант, так как исключает те вариантры, для которых не нужны ячейки (в случае ошибки)
// filterMap - то же самое, но обязаетльно возвращает одномерный массив, даже если изначальный массив был "массив массивов" :
//            let array = [[1, 2, 3], [1, 2, 3], [1, 2, 3]]
//            let filterArray = array.filterMap{ $0 }
//            filterArray - [1, 2, 3, 1, 2, 3, 1, 2, 3]
