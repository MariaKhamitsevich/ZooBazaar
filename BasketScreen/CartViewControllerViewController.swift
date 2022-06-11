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
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartView.cartTable.reloadData()
        cartView.totalPriceLabel.text = "Итого: " + String(cartManager.countTotalPrice()) + " BYN"
    }
    
    private func updateTotalCost() {
        cartView.totalPriceLabel.text = "Итого: " + String(cartManager.countTotalPrice()) + " BYN"
    }
}


