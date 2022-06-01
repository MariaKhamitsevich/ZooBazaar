//
//  SomeViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 21.05.22.
//

import UIKit

class SomeViewController: UIViewController {
    
    var someView: SomeView {
        view as! SomeView
    }
    
    override func loadView() {
        view = SomeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    

}
