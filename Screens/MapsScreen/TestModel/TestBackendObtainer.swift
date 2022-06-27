//
//  TestBackendObtainer.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 25.06.22.
//

import UIKit
import FirebaseFirestore

class TestBackendObtainer {
    
    var parseBackendData: [TestBackendProducts] = []
    var callBack: (() -> Void)?
    
    
    var pet: Pets
//    var currentBrand: String?
    
    init(pet: Pets, callBack: (() -> Void)? = nil) {
        self.pet = pet
        self.callBack = callBack
        loadData()
    }
    
    func obtainPet() -> TestPet {
        return  TestPet(pet: pet, backendData: self.parseBackendData)
    }
    
    func obtainPopularProducts() -> [TestBrandProducts] {
        let popularProducts = parseBackendData.flatMap {
            $0.brendProducts.filter { $0.isPopular}
        }
        return popularProducts
    }
    
    func loadData() {
        
        let db = Firestore.firestore()
        
        db.collection("BackendData").document(pet.rawValue).collection("backendData").getDocuments{ [weak self] (snapshot, error) in
            guard let self = self else { return }
            if let error = error {
                Swift.debugPrint(error.localizedDescription)
            } else if let snapshot = snapshot {
                                
                for i in snapshot.documents {
                    
                    let brandName = i.get("brendName") as? String ?? ""
                    let documentID = i.documentID
                    db.collection("BackendData").document(self.pet.rawValue).collection("backendData").document(documentID).collection("brendProducts").getDocuments { [weak self] (snapshot, error) in
                        guard let self = self else { return }
                        if let error = error {
                            Swift.debugPrint(error.localizedDescription)
                        } else if let snapshot = snapshot {
                            
                            var brendProducts: [TestBrandProducts] = []
                            
                            for i in snapshot.documents {
                                let product = TestBrandProducts.parseBrandProduct(productQuery: i)
                                brendProducts.append(product)
                            }
                            
                            self.parseBackendData.append(TestBackendProducts(brendName: brandName, brendProducts: brendProducts))
                            print("Neded number of sections: \(self.parseBackendData.count)")
                            self.callBack?()
                        }
                    }
                }
            }
        }
    }
}
