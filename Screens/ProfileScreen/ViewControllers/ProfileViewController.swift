//
//  ProfileViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 16.05.22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileView: ProfileView {
        view as! ProfileView
    }
            
    override func loadView() {
        view = ProfileView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
      
        profileView.exitButton.addTarget(self, action: #selector(returnToRegistration), for: .touchUpInside)
    }
    

    @objc func returnToRegistration() {
        navigationController?.pushViewController(RegistrationViewController(), animated: false)
        navigationController?.viewControllers.removeFirst()
    }
}
