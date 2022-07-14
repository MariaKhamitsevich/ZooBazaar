//
//  CatsProductsTableViewController.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 1.05.22.
//

import UIKit

final class ProductsTableViewController: UITableViewController {
   
    private(set)  var pets: PetProvider
    
    init(pets: PetProvider) {
        self.pets = pets
        super.init(style: UITableView.Style.grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableProperties()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    private func setTableProperties() {
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProductsTableViewCell.self, forCellReuseIdentifier: "ProductsTableViewCell")
        tableView.backgroundColor = ColorsManager.zbzbBackgroundColor
    }
    
    private func setNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backItem?.title = "Назад в каталог"
        navigationController?.navigationBar.tintColor = ColorsManager.zbzbTextColor
        navigationController?.navigationBar.barTintColor = ColorsManager.zbzbBackgroundColor
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
         pets.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ProductsTableHeaderView()
        view.title = pets.headerInSection(numberOfSection: section)
        return view
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pets.numberOfRowsInSection(numberOfSection: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell") as! ProductsTableViewCell
        cell.updateValues(product: pets.getProduct(numberOfSection: indexPath))
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DescriptionViewController()
        controller.prepareForPresent(product: pets.getProduct(numberOfSection: indexPath))
        present(controller, animated: true)
    }
}
