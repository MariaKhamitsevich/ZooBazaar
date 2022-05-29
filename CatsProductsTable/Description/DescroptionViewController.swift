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

        descriprionVeiw.exampleButton.addTarget(self, action: #selector(presentToController), for: .touchUpInside)
        descriprionVeiw.addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    }
    
    @objc func presentToController() {
//        let controller = SomeViewController()
//        present(controller, animated: true)
//
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeCubic) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                self.descriprionVeiw.exampleButton.transform = CGAffineTransform(scaleX: 0.98, y: 0.95)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.descriprionVeiw.exampleButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    }
    
    @objc func addToCart() {
        let controller = CartViewController()
        if let currentProduct = descriprionVeiw.currentProduct {
            cartManager.addProduct(product: currentProduct)
        }
        if let view = controller.view as? CartView {
            view.cartTable.reloadData()
        }
        
        self.descriprionVeiw.addToCartButton.animateButtonTap(view: self.descriprionVeiw, startWidth: 240, startHeight: 32)
//        UIView.animate(withDuration: 0.1, delay: .zero, options: .curveLinear, animations: {
//            self.descriprionVeiw.addToCartButton.snp.updateConstraints { make in
//                make.height.equalTo(30)
//                make.width.equalTo(235)
//            }
//            self.descriprionVeiw.layoutIfNeeded()
//        }, completion: {_ in
//            UIView.animate(withDuration: 0.1, delay: .zero, options: .curveLinear) {
//                self.descriprionVeiw.addToCartButton.snp.updateConstraints { make in
//                    make.height.equalTo(32)
//                    make.width.equalTo(240)
//                }
//                self.descriprionVeiw.layoutIfNeeded()
//            }
//
//        }
//        )
        
    }
}
