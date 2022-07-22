//
//  HomeTableViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 8.06.22.
//

import UIKit

final class HomeTableViewController: UITableViewController {

    private let petObtainer = BackendObtainer()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableProperties()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titlesForSections = ["Каталог", "Популярное"]
        let view = HomeScreenHeaders()
        view.title = titlesForSections[section]
        return view
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
         2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenTableViewCell", for: indexPath) as! HomeScreenTableViewCell
        cell.numberOfSectionInTable = indexPath.section
        cell.controllerDelegate = self
        cell.backgroundColor = .clear
        
        cell.backendObtainer = self.petObtainer
        cell.backendObtainer?.callBack = cell.collectionView.reloadData
        
        return cell
    }
    
    private func setTableProperties() {
        tableView.backgroundColor = .clear
        tableView.rowHeight = UIScreen.main.bounds.height / 3.4
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: "HomeScreenTableViewCell")
    }
}
