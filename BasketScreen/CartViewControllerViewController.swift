//
//  FavoritesViewController.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 27.04.22.
//

import UIKit
class CartTableViewSettings: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let cartManager = CartManager.shared
    
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
        
        cell.callBack = {
            
            if self.cartManager.productCount() == 1 {
                tableView.reloadData()
            } else {
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .bottom)
                
                tableView.endUpdates()
            }
        }
        return cell
    }
    
}

class CartViewController: UIViewController {
    
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartView.cartTable.reloadData()
    }
    
    
}


