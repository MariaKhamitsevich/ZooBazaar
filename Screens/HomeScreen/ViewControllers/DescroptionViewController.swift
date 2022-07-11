//
//  DescroptionViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import UIKit
import SnapKit

class DescroptionViewController: UIViewController {
    
    var productCount: Int = 1

    var descriprionVeiw: DescriprionView {
        view as! DescriprionView
    }
    
    weak var parentVC: UIViewController?
    
    override func loadView() {
        view = DescriprionView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        descriprionVeiw.amount.text = String(productCount)
        descriprionVeiw.addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        descriprionVeiw.increaseButton.addTarget(self, action: #selector(increaseAmount), for: .touchUpInside)
        descriprionVeiw.decreaseButton.addTarget(self, action: #selector(decreaseAmount), for: .touchUpInside)
    }
    
    @objc func addToCart() {
        let cartManager = CartManager.shared
        
        if var currentProduct = descriprionVeiw.currentProduct {
            currentProduct.productAmount = productCount
            cartManager.addProduct(product: currentProduct)
        }
        
        self.descriprionVeiw.addToCartButton.animateButtonTap(startWidth: 240, startHeight: 32) { _ in
            self.dismiss(animated: true)

        }
    }
    
    @objc func decreaseAmount() {
        if productCount != 1 {
            productCount -= 1
            descriprionVeiw.amount.text = String(productCount)
        }
    }
    
    @objc func increaseAmount() {
        productCount += 1
        descriprionVeiw.amount.text = String(productCount)
    }
}
