//
//  PetProvider.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import Foundation

struct PetProvider {
    private let petObtainer: BackendObtainer
    private let pets: [Pet]
    
    init(petObtainer: BackendObtainer) {
        self.petObtainer = petObtainer
        self.pets = self.petObtainer.obtainPets()
    }
    
    func numberOfSections(petType: Pets) -> Int {
        guard let petType = pets.first(where: { $0.pet == petType }) else { return 0}
        return  petType.products.count
    }
    
    func headerInSection(petType: Pets, numberOfSection section: Int) -> String {
        guard let petType = pets.first(where: { $0.pet == petType }) else { return ""}
        return  petType.products[section].brandName
    }
    
    func numberOfRowsInSection(petType: Pets, numberOfSection section: Int) -> Int {
        guard let petType = pets.first(where: { $0.pet == petType }) else { return 0}
        return  petType.products[section].brandProducts.count
    }
    
    func getProduct(petType: Pets, numberOfSection IndexPath: IndexPath) -> ProductSettable {
        guard let petType = pets.first(where: { $0.pet == petType }) else { return Product()}
        return  petType.products[IndexPath.section].brandProducts[IndexPath.row]
    }
    
    func getPopularProducts() -> [ProductSettable] {
        petObtainer.obtainPopularProducts()
    }
    
    private func sortProducts(products: [ProductsForPets]) -> [ProductsForPets] {
        products.sorted(by: { $0.brandName < $1.brandName })
    }
}
 
