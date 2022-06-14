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
        if registrationView.passwordForRegistrationTextField.text == registrationView.confirmPasswordTextField.text && registrationView.nameTextField.text != nil {
        self.navigationController?.pushViewController(controller, animated: true)
        self.navigationController?.viewControllers.removeFirst()
        }
    }
    
    @objc private func registrateProfile(_ sender: UIButton) {
        guard let email = registrationView.emailForRegistrationTextField.text,
              let password = registrationView.passwordForRegistrationTextField.text,
              let name = registrationView.nameTextField.text
        else {
            return
        }
        if registrationView.checkValidation(stack: registrationView.registrationStack) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                if error.localizedDescription == "The email address is already in use by another account." {
                    self.registrationView.getAlert(title: "Ошибка", message: "Пользователь с таким email уже существует", controller: self)
                } else
                { self.registrationView.getAlert(title: "Ошибка", message: "Попробуйте позже", controller: self)
                }
                print("Registration error: \(error.localizedDescription)")
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
        } else {
            registrationView.checkValidation(stack: registrationView.registrationStack)
        }
        
        
    }
    
    @objc private func signIn(_ sender: UIButton) {
        guard let email = registrationView.emailTextField.text,
              let password = registrationView.passwordTextField.text
        else {
            return
        }
        if registrationView.checkValidation(stack: registrationView.emailPasswordStack) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let self = self else { return }
            if let error = error {
                self.registrationView.getAlert(title: "Ошибка входа", message: "Проверьте имя пользователя или пароль", controller: self, completion: ({ self.registrationView.emailTextField.becomeFirstResponder()}))
                print("Registration error: \(error.localizedDescription)")
            } else if let authResult = authResult {
                self.goToProfile(email: authResult.user.email ?? "", name: authResult.user.displayName ?? "")
            }
        }
        } else {
            registrationView.checkValidation(stack: registrationView.emailPasswordStack)
    }
    }
}
