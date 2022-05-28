//
//  DescroptionViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import UIKit

class DescroptionViewController: UIViewController {

    var descriprionVeiw: DescriprionView {
        view as! DescriprionView
    }
    
    
    override func loadView() {
        view = DescriprionView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        descriprionVeiw.exampleButton.addTarget(self, action: #selector(presentToController), for: .touchUpInside)
        descriprionVeiw.addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    }
    
    @objc func presentToController() {
        let controller = SomeViewController()
        present(controller, animated: true)
    }
    
    @objc func addToCart() {
        let controller = CartViewController()
        if let currentProduct = descriprionVeiw.currentProduct {
        cartManager.addProduct(product: currentProduct)
        }
        if let view = controller.view as? CartView {
            view.cartTable.reloadData()
        }
    }

}
