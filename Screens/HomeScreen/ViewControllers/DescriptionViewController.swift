//
//  DescroptionViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import UIKit
import SnapKit

final class DescriptionViewController: UIViewController {
    
    let cartManager = CartManager.shared
    private var productCount: Int = 1
    
    var descriptionVeiw: DescriprionView {
        view as! DescriprionView
    }
    
    weak var parentVC: UIViewController?
    
    override func loadView() {
        view = DescriprionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewProperties()
    }
    
    func prepareForPresent(product: ProductSettable) {
        descriptionVeiw.update(product: product)
        descriptionVeiw.currentProduct = product
    }
    
    private func setViewProperties() {
        descriptionVeiw.amount.text = String(productCount)
        descriptionVeiw.addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        descriptionVeiw.increaseButton.addTarget(self, action: #selector(increaseAmount), for: .touchUpInside)
        descriptionVeiw.decreaseButton.addTarget(self, action: #selector(decreaseAmount), for: .touchUpInside)
    }
    
    @objc func addToCart() {
        
        if var currentProduct = descriptionVeiw.currentProduct {
            currentProduct.productAmount = productCount
            cartManager.addProduct(product: currentProduct)
        }
        
        self.descriptionVeiw.addToCartButton.animateButtonTap(startWidth: UIScreen.main.bounds.width / 4 * 3, startHeight: UIScreen.main.bounds.height * 0.05) { _ in
            self.dismiss(animated: true)
        }
    }
    
    @objc func decreaseAmount() {
        if productCount != 1 {
            productCount -= 1
            descriptionVeiw.productCount = productCount
        }
    }
    
    @objc func increaseAmount() {
        productCount += 1
        descriptionVeiw.productCount = productCount
    }
}
