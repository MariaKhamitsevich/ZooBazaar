//
//  PetProvider.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import Foundation

struct PetProvider {
    private let petObtainer: BackendObtainer
    private let pet: Pet
    
    init(petObtainer: BackendObtainer) {
        self.petObtainer = petObtainer
        self.pet = self.petObtainer.obtainPet()
    }
    
    var numberOfSections: Int {
        pet.products.count
    }
    
    func headerInSection(numberOfSection section: Int) -> String {
        pet.products[section].brendName
    }
    
    func numberOfRowsInSection(numberOfSection section: Int) -> Int {
        pet.products[section].brendProducts.count
    }
    
    func getProduct(numberOfSection IndexPath: IndexPath) -> Product {
        pet.products[IndexPath.section].brendProducts[IndexPath.row]
    }
    
    func getPopularProducts() -> [Product] {
        petObtainer.obtainPopularProducts()
    }
}
 
