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
    
    let queue = DispatchQueue(label: "com.Zoobazaar.BackendObtainer", qos: .userInitiated)
    
    init(pet: Pets, callBack: (() -> Void)? = nil) {
        self.pet = pet
        self.callBack = callBack
        loadData()
    }
    
    func obtainPet() -> Pet {
        Pet(pet: pet, products: self.parsedBackendData)
    }
    
    func obtainPopularProducts() -> [Product] {
        let popularProducts = parsedBackendData.flatMap {
            $0.brendProducts.filter { $0.isPopular}
        }
        return popularProducts
    }
    
    func obtainAllProducts() -> [Product] {
        let products = parsedBackendData.flatMap({$0.brendProducts})
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
                                
                                self.parsedBackendData.append(ProductsForPets(brendName: brandName, brendProducts: brendProducts))
                                self.callBack?()
                            }
                        }
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
