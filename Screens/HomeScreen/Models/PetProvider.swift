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
    private let products: [ProductsForPets]
    
    init(petObtainer: BackendObtainer) {
        self.petObtainer = petObtainer
        self.pet = self.petObtainer.obtainPet()
        
        //products sorted alphabetically by brandName
        self.products = self.pet.products.sorted { $0.brandName < $1.brandName }
    }
    
    var numberOfSections: Int {
        products.count
    }
    
    func headerInSection(numberOfSection section: Int) -> String {
        products[section].brandName
    }
    
    func numberOfRowsInSection(numberOfSection section: Int) -> Int {
        products[section].brandProducts.count
    }
    
    func getProduct(numberOfSection IndexPath: IndexPath) -> ProductSettable {
        products[IndexPath.section].brandProducts[IndexPath.row]
    }
    
    func getPopularProducts() -> [ProductSettable] {
        petObtainer.obtainPopularProducts()
    }
}
 
