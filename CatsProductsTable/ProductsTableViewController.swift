//
//  CatsProductsTableViewController.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 1.05.22.
//

import UIKit

protocol TableDataReloading: AnyObject {
    func reload()
}

class ProductsTableViewController: UITableViewController, TableDataReloading {
    
    
    
    var pets: PetProvider
    
    init(pets: PetProvider) {
        self.pets = pets
        super.init(style: UITableView.Style.grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProductsTableViewCell.self, forCellReuseIdentifier: "ProductsTableViewCell")
        tableView.backgroundColor = ColorsManager.zbzbBackgroundColor
        

       

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backItem?.title = "Назад в каталог"
        navigationController?.navigationBar.tintColor = ColorsManager.zbzbTextColor
        navigationController?.navigationBar.barTintColor = ColorsManager.zbzbBackgroundColor
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return pets.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ProductsTableHeaderView()
        view.title = pets.headerInSection(numberOfSection: section)
        return view
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        pets.numberOfRowsInSection(numberOfSection: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell") as! ProductsTableViewCell
        cell.tableReloadDelegate = self
        cell.updateValues(product: pets.getProduct(numberOfSection: indexPath))
        return cell
    }
    
    func reload() {
        
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.reloadRows(at: [index], with: .none)
        } else {
            self.tableView.reloadRows(at: [], with: .none)
        }
        
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DescroptionViewController()
        controller.descriprionVeiw.update(product: pets.getProduct(numberOfSection: indexPath))
        controller.descriprionVeiw.currentProduct = pets.getProduct(numberOfSection: indexPath)
        present(controller, animated: true)
    }
   
    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
////         Return false if you do not want the specified item to be editable.
//
//        return true
//    }
   

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
