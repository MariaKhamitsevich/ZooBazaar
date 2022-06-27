//
//  TestPetProvider.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 25.06.22.
//

import Foundation

struct TestPetProvider {
    private var petObtainer: TestBackendObtainer
    private var pet: TestPet
    var callBack: (() -> Void)?
    
    init(petObtainer: TestBackendObtainer) {
        self.petObtainer = petObtainer
        self.pet = self.petObtainer.obtainPet()
        print(self.pet)
        self.petObtainer.callBack = self.callBack
    }
    
    var numberOfSections: Int {
        print("Number of sections: \(        self.pet.backendData.count)")
     return self.pet.backendData.count
    }
    
    func headerInSection(numberOfSection section: Int) -> String {
        self.pet.backendData[section].brendName
    }
    
    func numberOfRowsInSection(numberOfSection section: Int) -> Int {
        self.pet.backendData[section].brendProducts.count
    }
    
    func getProduct(numberOfSection IndexPath: IndexPath) -> TestBrandProducts {
        self.pet.backendData[IndexPath.section].brendProducts[IndexPath.row]
    }
    
//    func getPopularProducts() -> [Product] {
//        self.petObtainer.obtainPopularProducts()
//    }
}
