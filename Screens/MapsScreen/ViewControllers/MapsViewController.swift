//
//  MapsViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 9.05.22.
//

import UIKit

final class MapsViewController: UIViewController {
    
    var mapsView: MapsView {
        view as! MapsView
    }
    
    override func loadView() {
        view = MapsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
}
