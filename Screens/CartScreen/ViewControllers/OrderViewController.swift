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

final class OrderViewController: UIViewController, UITextFieldDelegate {
    
    private let cartManager = CartManager.shared
    private var orderSender: OrderSender
    
    private var orderView: OrderView {
        view as! OrderView
    }
    
    override func loadView() {
        view = OrderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAllTargets()
        addAddress()
        addPhoneNumber()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        if let products = cartManager.cartProducts as? [Product] {
        self.orderSender = OrderSender(products: products)
        } else {
            self.orderSender = OrderSender(products: [])
        }
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
        orderView.orderPriceLabel.text = "Сумма заказа: \(cartManager.countTotalPrice()) руб."
    }
    
    private func setNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backItem?.title = "Назад в корзину"
        navigationController?.navigationBar.tintColor = ColorsManager.zbzbTextColor
    }
    
    private func addAllTargets() {
        orderView.addressTextField.delegate = self
        orderView.telephoneTextField.delegate = self
        
        orderView.delivaryMethodSegmentedControl.addTarget(self, action: #selector(chooseSegmentedControl(_:)), for: .valueChanged)
        orderView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewDidTapped)))
        orderView.orderingButton.addTarget(self, action: #selector(orderButtonAction), for: .touchUpInside)
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
    
    @objc func orderButtonAction() {
        orderView.addressTextField.layer.borderWidth = 0
        orderView.telephoneTextField.layer.borderWidth = 0
        
        orderView.orderingButton.animateButtonTap(startWidth: UIScreen.main.bounds.width / 3 * 2, startHeight: UIScreen.main.bounds.height * 0.05, completion: { [weak self] _ in
            guard let self = self else { return }
            if self.checkAddressAndPhone() {
                self.sendOrder()
            }
        })
    }
    
    private func sendOrder() {
        orderView.orderingButton.isEnabled = false
        
        let deliveryControl = orderView.delivaryMethodSegmentedControl
        
        var delivaryMethod = ""
        switch deliveryControl.selectedSegmentIndex {
        case 0:
            delivaryMethod = "Delivery"
        default:
            delivaryMethod = "Pickup"
        }
        
        orderSender.sentOrder(
            delivaryMethod: delivaryMethod,
            totalCost: cartManager.countTotalPrice(),
            errorCompletion: { [weak self] in
                let alert = ZBZAlert(title: "Ошибка", message: "Пожалуйста, попробуйте позже", preferredStyle: .alert)
                alert.getAlert(controller: self)
            },
            successCompletion: { [weak self] in
                self?.cartManager.cleanCart()
                self?.orderView.orderingButton.isEnabled = true
                self?.navigationController?.popViewController(animated: true)
            })
    }
    
    private func checkAddressAndPhone() -> Bool {

        var message = ""
        let regex: RegexType = .phone
        
        if orderView.addressTextField.text == "" {
            message += "Введите адрес"
            orderView.addressTextField.layer.borderColor = UIColor.red.cgColor
            orderView.addressTextField.layer.borderWidth = 0.4
        }
        
        if orderView.telephoneTextField.text == "" {
            message += "\nВведите номер телефона"
            orderView.telephoneTextField.layer.borderColor = UIColor.red.cgColor
            orderView.telephoneTextField.layer.borderWidth = 0.4
        } else if  let text = orderView.telephoneTextField.text {
            if !text.matches(regex.rawValue) {
                message += "\nПроверьте введенный номер"
            }
        }
        
        if message != "" {
            let alert = ZBZAlert(title: nil, message: message, preferredStyle: .alert)
            alert.getAlert(controller: self, completion: { [weak self] in
                if message.contains("Введите адрес") {
                    self?.orderView.addressTextField.becomeFirstResponder()
                } else if message.contains("Введите номер телефона") || message.contains("Проверьте введенный номер") {
                    self?.orderView.telephoneTextField.becomeFirstResponder()
                }
            })
            return false
        }
        
        return true
    }
    
    private func addAddress() {
        let user = Auth.auth().currentUser
        let uid = user?.uid
        
        let db = Firestore.firestore()
        if let uid = uid {
            db.collection("UserAddresses").document(uid).getDocument { [weak self] (snapshot, error) in
                if let error = error {
                    Swift.debugPrint(error.localizedDescription)
                } else if let snapshot = snapshot {
                    let text = snapshot.get("UserAddress")
                    self?.orderView.addressTextField.text = text as? String ?? ""
                }
            }
        }
    }
    
    private func addPhoneNumber() {
        let user = Auth.auth().currentUser
        let uid = user?.uid
        
        let db = Firestore.firestore()
        if let uid = uid {
            db.collection("UserPhone").document(uid).getDocument { [weak self] (snapshot, error) in
                if let error = error {
                    Swift.debugPrint(error.localizedDescription)
                } else if let snapshot = snapshot {
                    let text = snapshot.get("UserPhoneNumber")
                    self?.orderView.telephoneTextField.text = text as? String ?? ""
                }
            }
        }
    }
}

