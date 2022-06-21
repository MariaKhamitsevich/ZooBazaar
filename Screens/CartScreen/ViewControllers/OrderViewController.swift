//
//  OrderViewController.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 21.06.22.
//

import UIKit

class OrderViewController: UIViewController {
    
    var navigationBarHeight: CGFloat?
    
    private var orderView: OrderView {
        view as! OrderView
    }
    
    override func loadView() {
        view = OrderView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backItem?.title = "Назад в корзину"
        navigationController?.navigationBar.tintColor = ColorsManager.zbzbTextColor
    }
}
