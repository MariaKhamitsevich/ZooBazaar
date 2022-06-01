//
//  DescroptionViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import UIKit
import SnapKit

class DescroptionViewController: UIViewController {

    var descriprionVeiw: DescriprionView {
        view as! DescriprionView
    }
    
    
    override func loadView() {
        view = DescriprionView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        descriprionVeiw.addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    }
    
    @objc func addToCart() {
        let controller = CartViewController()
        let cartManager = CartManager.shared
        
        if let currentProduct = descriprionVeiw.currentProduct {
            cartManager.addProduct(product: currentProduct)
        }
        if let view = controller.view as? CartView {
            view.cartTable.reloadData()
        }
        
        self.descriprionVeiw.addToCartButton.animateButtonTap(startWidth: 240, startHeight: 32) { _ in
            self.dismiss(animated: true)

        }
        
    }
}
