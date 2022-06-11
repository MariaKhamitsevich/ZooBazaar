//
//  ProfileViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 9.05.22.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private var registrationView: RegistrationView {
        view as! RegistrationView
    }
    
    override func loadView() {
        view = RegistrationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        registrationView.confirmButton.addTarget(self, action: #selector(runToProfile), for: .touchUpInside)
        registrationView.registrationButton.addTarget(self, action: #selector(runToProfile), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    @objc private func runToProfile(_ sender: UIButton) {
        let controller = ProfileViewController()
        controller.profileView.setEmail(email: registrationView.email)
        controller.profileView.setName(name: registrationView.name)
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.viewControllers.removeFirst()
    }
}
