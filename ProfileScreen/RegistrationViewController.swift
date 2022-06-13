//
//  ProfileViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 9.05.22.
//

import UIKit
import FirebaseAuth
import FirebaseCore

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
        
        registrationView.confirmButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        registrationView.registrationButton.addTarget(self, action: #selector(registrateProfile), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    

    private func goToProfile(email: String, name: String) {
        let controller = ProfileViewController()
        controller.profileView.setEmail(email: email)
        controller.profileView.setName(name: name)
        self.navigationController?.pushViewController(controller, animated: true)
        self.navigationController?.viewControllers.removeFirst()
    }
    
    @objc private func registrateProfile(_ sender: UIButton) {
        guard let email = registrationView.emailForRegistrationTextField.text,
              let password = registrationView.passwordForRegistrationTextField.text,
              let name = registrationView.nameTextField.text
        else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                print("Registration error: \(error)")
            } else if let authResult = authResult {
                let userChange = authResult.user.createProfileChangeRequest()
                userChange.displayName = name
                userChange.commitChanges() { error in
                    if let error = error {
                        print("Name change error: \(error)")
                    } else {
                        self.goToProfile(email: authResult.user.email ?? "", name: name)
                    }
                }
            }
        }
        registrationView.checkValidation(stack: registrationView.registrationStack)
        
    }
    
    @objc private func signIn(_ sender: UIButton) {
        guard let email = registrationView.emailTextField.text,
              let password = registrationView.passwordTextField.text
        else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let self = self else { return }
            if let error = error {
                print("Registration error: \(error)")
            } else if let authResult = authResult {
                self.goToProfile(email: authResult.user.email ?? "", name: authResult.user.displayName ?? "")
            }
        }
    }
}
