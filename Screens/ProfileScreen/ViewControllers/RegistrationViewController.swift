//
//  ProfileViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 9.05.22.
//

import UIKit
import FirebaseAuth
import FirebaseCore

final class RegistrationViewController: UIViewController {
    
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
        
        addAllTargets()
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
        
        registrationView.registrationStack.subviews.forEach( { subview in
            subview.layer.borderWidth = 0
        })
        
        if checkValidation(stack: registrationView.registrationStack) {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                if let error = error {
                    if error.localizedDescription == "The email address is already in use by another account." {
                        self.registrationView.emailForRegistrationTextField.layer.borderWidth = 0.4
                        self.getAlert(title: "????????????", message: "???????????????????????? ?? ?????????? email ?????? ????????????????????", controller: self)
                    } else
                    { self.getAlert(title: "????????????", message: "???????????????????? ??????????", controller: self)
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
        }
        sender.animateButtonTap(startWidth: UIScreen.main.bounds.width / 3 * 2, startHeight: UIScreen.main.bounds.height * 0.05, completion: nil)
    }
    
    @objc private func signIn(_ sender: UIButton) {
        guard let email = registrationView.emailTextField.text,
              let password = registrationView.passwordTextField.text
        else {
            return
        }
        
        registrationView.emailPasswordStack.subviews.forEach( { subview in
            subview.layer.borderWidth = 0
        })
        
        if checkValidation(stack: registrationView.emailPasswordStack) {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                if let error = error {
                    self.getAlert(title: "???????????? ??????????", message: "?????????????????? ?????? ???????????????????????? ?????? ????????????", controller: self, completion: ({
                        self.registrationView.emailPasswordStack.subviews.forEach( { subview in
                            subview.layer.borderWidth = 0.4
                        })
                        self.registrationView.emailTextField.becomeFirstResponder()}))
                    print("Registration error: \(error.localizedDescription)")
                } else if let authResult = authResult {
                    self.goToProfile(email: authResult.user.email ?? "", name: authResult.user.displayName ?? "")
                }
            }
        }
        sender.animateButtonTap(startWidth: UIScreen.main.bounds.width / 3 * 2, startHeight: UIScreen.main.bounds.height * 0.05, completion: nil)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
    //MARK: Add all targets
    private func addAllTargets() {
        registrationView.emailTextField.delegate = self
        registrationView.passwordTextField.delegate = self
        registrationView.nameTextField.delegate = self
        registrationView.emailForRegistrationTextField.delegate = self
        registrationView.passwordForRegistrationTextField.delegate = self
        registrationView.confirmPasswordTextField.delegate = self
        
        //Added target on return button
        registrationView.registrationStack.arrangedSubviews.forEach( { [weak self] subview in
            if let self = self {
                if let subview = subview as? UITextField {
                    subview.addTarget(self, action: #selector(pressReturn), for: .primaryActionTriggered)
                }
            }
        })
        registrationView.emailPasswordStack.arrangedSubviews.forEach( { [weak self] subview in
            if let self = self {
                if let subview = subview as? UITextField {
                    subview.addTarget(self, action: #selector(pressReturn), for: .primaryActionTriggered)
                }
            }
        })
        
        //Hide textFields by tap of segmentedControl
        registrationView.registrationSegmentedControl.addTarget(self, action: #selector(chooseSegmentedControl), for: .valueChanged)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let color = ColorsManager.zbzbTextColor.withAlphaComponent(0.5)
        let attributes = [NSAttributedString.Key.foregroundColor: color,
                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "",
                                                             attributes: attributes)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let color = ColorsManager.zbzbTextColor.withAlphaComponent(0.5)
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "",
                                                             attributes: attributes)
        textField.resignFirstResponder()
        return true
    }
    
    @objc func pressReturn(_ sender: UITextField) {
        sender.attributedPlaceholder = NSAttributedString(string: sender.placeholder ?? "")
        registrationView.endEditing(true)
    }
    
    @objc private func chooseSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            registrationView.emailPasswordStack.isHidden = false
            registrationView.confirmButton.isHidden = false
            registrationView.rememberLabel.isHidden = false
            registrationView.registrationStack.isHidden = true
            registrationView.registrationButton.isHidden = true
        case 1:
            registrationView.emailPasswordStack.isHidden = true
            registrationView.confirmButton.isHidden = true
            registrationView.rememberLabel.isHidden = true
            registrationView.registrationStack.isHidden = false
            registrationView.registrationButton.isHidden = false
            
        default:
            registrationView.registrationStack.isHidden = true
        }
    }
    
    private func checkValidation(stack: UIStackView) -> Bool {
        
        var regex: RegexType = .password
        var message = ""
        let titleAlertRegistration = "???????????? ??????????????????????"
        let signInTitle = "???????????? ??????????"
        var title = ""
        
        
        stack.arrangedSubviews.forEach{ subvew in
            if let textField = subvew as? UITextField {
                
                switch textField.textContentType {
                case .emailAddress?:
                    regex = .email
                case .password?:
                    regex = .password
                default:
                    break
                }
                
                let text = textField.text ?? ""
                
                switch textField {
                case registrationView.nameTextField:
                    if  text == "" {
                        message = "?????????????? ?????? ????????????????????????"
                        title = titleAlertRegistration
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.layer.borderWidth = 0.4
                    }
                case registrationView.emailForRegistrationTextField:
                    title = titleAlertRegistration
                    if  text == "" {
                        message += "\n?????????????? email"
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.layer.borderWidth = 0.4
                    } else if !text.matches(regex.rawValue) {
                        message += "\n?????????????????? ?????????????????? email"
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.layer.borderWidth = 0.4
                    }
                case registrationView.passwordForRegistrationTextField:
                    title = titleAlertRegistration
                    if  text == "" {
                        message += "\n?????????????? ????????????"
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.layer.borderWidth = 0.4
                    } else if !text.matches(regex.rawValue) {
                        message += "\n???????????? ???????????? ?????????????????? ?????????????? 6 ????????????????, 1 ?????????????????? ???????????? ?? 1 ??????????."
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.layer.borderWidth = 0.4
                    }
                case registrationView.confirmPasswordTextField:
                    title = titleAlertRegistration
                    if text != registrationView.passwordForRegistrationTextField.text && registrationView.passwordForRegistrationTextField.text != nil {
                        message += "\n???????????????? ???????????? ?????? ??????????????????????????"
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.layer.borderWidth = 0.4
                    }
                case registrationView.emailTextField:
                    title = signInTitle
                    if  text == "" {
                        message = "?????????????? email"
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.layer.borderWidth = 0.4
                    }
                case registrationView.passwordTextField:
                    title = signInTitle
                    if  text == "" {
                        message += "\n?????????????? ????????????"
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.layer.borderWidth = 0.4
                    }
                default :
                    return
                }
            }
        }
        if message != "" {
            getAlert(title: title, message: message, controller: self, completion: {
                switch stack {
                case self.registrationView.registrationStack:
                    if message.contains("?????????????? ?????? ????????????????????????") {
                        self.registrationView.nameTextField.becomeFirstResponder()
                    } else if message.contains("?????????????? email") || message.contains("?????????????????? ?????????????????? email") {
                        self.registrationView.emailForRegistrationTextField.becomeFirstResponder()
                    } else if message.contains("?????????????? ????????????") || message.contains("???????????? ???????????? ?????????????????? ?????????????? 6 ????????????????, 1 ?????????????????? ???????????? ?? 1 ??????????") {
                        self.registrationView.passwordForRegistrationTextField.becomeFirstResponder()
                    } else if message.contains("???????????????? ???????????? ?????? ??????????????????????????") {
                        self.registrationView.confirmPasswordTextField.becomeFirstResponder()
                    }
                case self.registrationView.emailPasswordStack:
                    if message.contains("?????????????? email") {
                        self.registrationView.emailTextField.becomeFirstResponder()
                    } else if message.contains("?????????????? ????????????"){
                        self.registrationView.passwordTextField.becomeFirstResponder()
                    }
                default: break
                }
            })
            return false
        }
        return true
    }
    
   private func getAlert(title: String?, message: String?, controller: UIViewController?, completion: (() -> Void)? = nil) {
        registrationView.endEditing(true)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            completion?()
        }))
        
        controller?.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
