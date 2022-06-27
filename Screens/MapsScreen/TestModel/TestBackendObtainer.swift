//
//  TestBackendObtainer.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 25.06.22.
//

import UIKit
import FirebaseFirestore

class TestBackendObtainer {
    
    //MARK: QueryDocumentSnapshot
    var testPet: [QueryDocumentSnapshot] = []
    var testCurrentPet: QueryDocumentSnapshot? {
        for i in testPet {
            let pet = i.documentID
            if pet == self.pet.rawValue {
                return i
            }
        }
        return nil
    }
    
    //Бренды продуктов
    var testBackendData: [QueryDocumentSnapshot] = []
    
    //Продукты определенного бренда
    var testBrandProducts: [QueryDocumentSnapshot] = []
    
    //MARK: parseProducts
    var parsePet: TestPet?
    var parseBackendData: [TestBackendProducts] = []
    var parseBrandProducts: [TestBrandProducts] = []
    var callBack: (() -> Void)?
    
    
    var pet: PetsKinds
    var currentBrand: String?
    
    enum PetsKinds: String {
        case catsProducts = "catsBackendData"
    }
    
    init(pet: PetsKinds, callBack: (() -> Void)? = nil) {
        self.pet = pet
        self.callBack = callBack
        loadData()
    }
    
    func obtainPet() -> TestPet {

        return  TestPet(pet: Pets.init(rawValue: self.pet.rawValue) ?? .cats, backendData: self.parseBackendData)
    }
    
    func loadData() {
        let db = Firestore.firestore()
//        db.collection("BackendData").getDocuments { [weak self] (snapshot, error) in
//            guard let self = self else { return }
//            if let error = error {
//                Swift.debugPrint(error.localizedDescription)
//            } else if let snapshot = snapshot {
//                self.testPet = snapshot.documents
//
//            }
//        }
        
        db.collection("BackendData").document(pet.rawValue).collection("backendData").getDocuments{ [weak self] (snapshot, error) in
            guard let self = self else { return }
            if let error = error {
                Swift.debugPrint(error.localizedDescription)
            } else if let snapshot = snapshot {
                self.testBackendData = snapshot.documents
                print("Data from firebase: \(snapshot.documents)")
                
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
//                            if i.exists {
//                                self.callBack?()
//                            }
                        }
                    }
                }
            }
            
        }
    }
}
//    func getCurrentBrand(index: Int) {
//        var array: [QueryDocumentSnapshot]?
//        let db = Firestore.firestore()
//        db.collection("BackendData").document(pet.rawValue).collection("backendData").getDocuments { [weak self] (snapshot, error) in
//            guard let self = self else { return }
//            if let error = error {
//                Swift.debugPrint(error.localizedDescription)
//            } else if let snapshot = snapshot {
//                self.currentBrand =  snapshot.documents[index].documentID
//
//                if let currentBrand = self.currentBrand {
//                    db.collection("BackendData").document(self.pet.rawValue).collection("backendData").document(currentBrand).collection("brendProducts").getDocuments{ [weak self] (snapshot, error) in
//                        guard let self = self else { return }
//                        if let error = error {
//                            Swift.debugPrint(error.localizedDescription)
//                        } else if let snapshot = snapshot {
//                            array = snapshot.documents
//
//                            if let array = array {
//                                for i in array {
//                                    let element = TestBrandProducts.parseBrandProduct(productQuery: i)
//                                    self.parseBrandProducts.append(element)
//                                }
//                            }
//                        }
//                    }
//                }
//                print("Current brand: \(self.currentBrand ?? "")")
//            }
//        }
//    }
