//
//  HomeTableViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 8.06.22.
//

import UIKit

class HomeTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .clear
        tableView.rowHeight = UIScreen.main.bounds.height / 3.4
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: "HomeScreenTableViewCell")
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titlesForSections = ["Каталог", "Популярное"]
        let view = HomeScreenHeaders()
        view.title = titlesForSections[section]
        return view
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenTableViewCell", for: indexPath) as! HomeScreenTableViewCell
        cell.numberOfSectionInTable = indexPath.section
        cell.controllerDelegate = self
        cell.backgroundColor = .clear
        return cell
    }
}
