//
//  OrdersTableViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 2.07.22.
//

import UIKit

final class OrdersTableViewController: UITableViewController {
    
   private var orderProvider: OrderProvider
    
    init(orderProvider: OrderProvider) {
        self.orderProvider = orderProvider
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableProperties()
        setNavigatinBar()
    }
   
    //MARK: Table Properties
    private func setTableProperties() {
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OrdersTableViewCell.self, forCellReuseIdentifier: "OrdersTableViewCell")
        tableView.backgroundColor = ColorsManager.zbzbBackgroundColor
    }
    
    //MARK: NavigationBar
    private func setNavigatinBar() {
        navigationController?.isNavigationBarHidden = false
        let backButton = UIBarButtonItem()
        backButton.title = "Профиль"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = ColorsManager.zbzbTextColor
        navigationController?.navigationBar.barTintColor = ColorsManager.zbzbBackgroundColor
        
        self.title = "История заказов"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22).boldItalic(), NSAttributedString.Key.foregroundColor : ColorsManager.zbzbTextColor]
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        orderProvider.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderProvider.numberOfRowsInSection(numberOfSection: section)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = OrderHeader()
        view.title = orderProvider.headerInSection(numberOfSection: section)
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersTableViewCell") as! OrdersTableViewCell

        cell.updateValue(product: orderProvider.getProduct(numberOfSection: indexPath))
        cell.backgroundColor = .clear
        cell.selectionStyle = .none

        return cell
    }
  
}
