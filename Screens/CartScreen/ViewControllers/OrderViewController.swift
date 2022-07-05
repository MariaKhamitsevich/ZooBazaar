//
//  OrderViewController.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 21.06.22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

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
        orderView.orderingButton.addTarget(self, action: #selector(sendOrder), for: .touchUpInside)
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
    
    @objc func sendOrder() {
        let user = Auth.auth().currentUser
        
        let deliveryControl = orderView.delivaryMethodSegmentedControl
        var delivaryMethod = ""
        switch deliveryControl.selectedSegmentIndex {
        case 0:
            delivaryMethod = "Delivery"
        default:
            delivaryMethod = "Pickup"
        }
        
        let date = Date()
        let calendar = NSCalendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let nanosecond = calendar.component(.nanosecond, from: date)
        let millisecond = nanosecond / 1000000
        var productsDictionary: [String : Any] = [:]
        
        let currentData = "\(year).\(month).\(day).\(hour).\(minutes).\(seconds).\(millisecond)"
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yy"
        let stringDate = dateFormater.string(from: date)
        
        
        if let uid = user?.uid {
            let db = Firestore.firestore()
            
            for product in cartManager.cartProducts {
                productsDictionary["\(product.productName)"] = [
                    "productName" : product.productName,
                    "productDescription": product.productDescription,
                    "productImageURL" : product.productImageURL ?? "",
                    "productPrice" : product.productPrice,
                    "isPopular" : product.isPopular,
                    "productID" : product.productID,
                    "productAmount" : product.productAmount]
            }
            
            db.collection("UsersOrders").document(uid).collection("Orders").document(currentData).setData(
                ["TotalCost" : cartManager.countTotalPrice(),
                 "CurrentDate" : stringDate,
                 "deliveryMethod" : delivaryMethod,
                 "Products" : productsDictionary
                ]){ [weak self] error in
                    if let error = error {
                        Swift.debugPrint(error.localizedDescription)
                    } else {
                        self?.cartManager.cleanCart()
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
        }
    }
}

