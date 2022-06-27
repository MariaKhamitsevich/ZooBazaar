//
//  PetProvider.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import Foundation

struct PetProvider {
    private var petObtainer: BackendObtainer
    private var pet: Pet
    
    init(petObtainer: BackendObtainer) {
        self.petObtainer = petObtainer
        self.pet = self.petObtainer.obtainPet()
    }
    
    var numberOfSections: Int {
        self.pet.products.count
    }
    
    func headerInSection(numberOfSection section: Int) -> String {
        self.pet.products[section].brendName
    }
    
    func numberOfRowsInSection(numberOfSection section: Int) -> Int {
        self.pet.products[section].brendProducts.count
    }
    
    func getProduct(numberOfSection IndexPath: IndexPath) -> Product {
        self.pet.products[IndexPath.section].brendProducts[IndexPath.row]
    }
    
    func getPopularProducts() -> [Product] {
        self.petObtainer.obtainPopularProducts()
    }
}
 
