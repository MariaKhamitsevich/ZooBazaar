//
//  OrderViewController.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 21.06.22.
//

import UIKit

class OrderViewController: UIViewController, UITextFieldDelegate {
    
    let cartManager = CartManager.shared
    var navigationBarHeight: CGFloat?
    
    private var orderView: OrderView {
        view as! OrderView
    }
    
    override func loadView() {
        view = OrderView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAllTargets()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backItem?.title = "Назад в корзину"
        navigationController?.navigationBar.tintColor = ColorsManager.zbzbTextColor
        orderView.orderPriceLabel.text = "Сумма заказа: \(cartManager.countTotalPrice()) руб."
    }
    
    private func addAllTargets() {
        orderView.addressTextField.delegate = self
        orderView.telephoneTextField.delegate = self
        
        orderView.delivaryMethodSegmentedControl.addTarget(self, action: #selector(chooseSegmentedControl(_:)), for: .valueChanged)
        orderView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewDidTapped)))
    }
    
    @objc private func chooseSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            orderView.pickupAddressControl.isHidden = true
            orderView.deliveryStack.isHidden = false
        default:
            orderView.pickupAddressControl.isHidden = false
            orderView.deliveryStack.isHidden = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
   @objc private func viewDidTapped() {
        self.view.endEditing(true)
    }
}
