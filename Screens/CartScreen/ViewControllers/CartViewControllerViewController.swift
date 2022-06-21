//
//  FavoritesViewController.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 27.04.22.
//

import UIKit
class CartTableViewSettings: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let cartManager = CartManager.shared
    var updateTotalCost: (() -> Void)?
    var checkEmpty: (() -> Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartManager.productCount()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell") as! CartTableViewCell
        
        cell.updateValue(product: cartManager.getProduct(indexPath: indexPath), indexPath: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        cell.callBack = {
            if self.cartManager.productCount() == 1 {
                tableView.reloadData()
                self.updateTotalCost?()
            } else {
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .bottom)
                tableView.endUpdates()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    tableView.reloadData()
                }
                self.updateTotalCost?()
                self.checkEmpty?()
            }
        }
        
        cell.reloadCell = {
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath], with: .none)
            tableView.endUpdates()
            self.updateTotalCost?()
        }
        
        cell.reloadTable = {
            tableView.reloadData()
            self.updateTotalCost?()
        }
        
        return cell
    }
    
    
}

class CartViewController: UIViewController {
    
    let cartManager = CartManager.shared
    var cartTableDelegate = CartTableViewSettings()
    private var cartView: CartView {
        view as! CartView
    }
    
    override func loadView() {
        view = CartView()
        cartView.cartTable.delegate = cartTableDelegate
        cartView.cartTable.dataSource = cartTableDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartView.cartTable.rowHeight = UITableView.automaticDimension
        cartView.cartTable.register(CartTableViewCell.self, forCellReuseIdentifier: "CartTableViewCell")
        cartView.cartTable.separatorStyle = .singleLine
        cartView.cartTable.tableFooterView = UIView(frame: .zero)
        cartTableDelegate.updateTotalCost = updateTotalCost
        cartTableDelegate.checkEmpty = checkEmpty
        navigationController?.isNavigationBarHidden = true
        
        cartView.orderingButton.addTarget(self, action: #selector(makeOrder), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        cartView.cartTable.reloadData()
        cartView.totalPriceLabel.text = "Итого: " + String(cartManager.countTotalPrice()) + " BYN"
        checkEmpty()
    }
    
    private func updateTotalCost() {
        cartView.totalPriceLabel.text = "Итого: " + String(cartManager.countTotalPrice()) + " BYN"
    }
    
   @objc private func makeOrder() {
       let controller = OrderViewController()
       navigationController?.pushViewController(controller, animated: true)
    }
    
    private func checkEmpty() {
        if cartManager.productCount() != 0 {
            cartView.insteadeOfTableLabel.isHidden = true
            cartView.totalPriceLabel.isHidden = false
            cartView.orderingButton.isEnabled = true
            cartView.orderingButton.alpha = 1
        } else {
            cartView.insteadeOfTableLabel.isHidden = false
            cartView.totalPriceLabel.isHidden = true
            cartView.orderingButton.isEnabled = false
            cartView.orderingButton.alpha = 0.7
        }
    }
}


