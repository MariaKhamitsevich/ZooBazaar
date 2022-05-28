//
//  FavoritesViewController.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 27.04.22.
//

import UIKit
class CartTableViewSettings: NSObject, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartManager.productCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell") as! CartTableViewCell
        cell.updateValue(product: cartManager.getProduct(indexPath: indexPath))
        cell.backgroundColor = .clear
        
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
        cartView.cartTable.separatorStyle = .none
        cartView.cartTable.tableFooterView = UIView(frame: .zero)
        
                
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartView.cartTable.reloadData()
    }

    

}
