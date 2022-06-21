//
//  OrderViewController.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 21.06.22.
//

import UIKit

class OrderViewController: UIViewController {
    
    private var orderView: OrderView {
        view as! OrderView
    }
    
    override func loadView() {
        view = OrderView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
