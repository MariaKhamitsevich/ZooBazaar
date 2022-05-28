//
//  SettingsViewController.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 27.04.22.
//

import UIKit


class SettingsViewController: UIViewController {
    
    var redValue: Float = 0
    var greenValue: Float = 0
    var blueValue: Float = 0
    weak var backgroundDelegate: BackgroundColorSetable?
    let settingView = SettingsView()
  
    
    override func loadView() {
        view = settingView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingView.setColors(red: redValue, green: greenValue, blue: blueValue)
            }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let view = view as? SettingsView {
            backgroundDelegate?.setBackgroundColor(
                red: view.red,
                green: view.green,
                blue: view.blue,
                alpha: 1)
            
        }
    }
}


