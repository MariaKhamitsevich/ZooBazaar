//
//  MapsViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 9.05.22.
//

import UIKit

class MapsViewController: UIViewController {
    var petObtainer: TestBackendObtainer?
    
    var mapsView: MapsView {
        view as! MapsView
    }
    
    override func loadView() {
        view = MapsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        petObtainer = TestBackendObtainer(pet: .catsProducts, callBack: { bool in
            self.mapsView.addToCartButton.isEnabled = true
        })

        mapsView.addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    }
    
    @objc func addToCart() {
//        let petObtainer = TestBackendObtainer(pet: .catsProducts)
        if let petObtainer = petObtainer {
            let petProvider = TestPetProvider(petObtainer: petObtainer)
            let controller = TestTableViewController(pets: petProvider)
            self.navigationController?.pushViewController(controller, animated: true)
        }
      
    }
    
}
