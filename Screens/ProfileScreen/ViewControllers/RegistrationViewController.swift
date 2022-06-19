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
    
    private let regexForPassword = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
    private let regexForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    //    "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$&*])[A-Za-z\\d!@#$&*]{6,}$"
    
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
                        self.getAlert(title: "Ошибка", message: "Пользователь с таким email уже существует", controller: self)
                    } else
                    { self.getAlert(title: "Ошибка", message: "Попробуйте позже", controller: self)
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
                    self.getAlert(title: "Ошибка входа", message: "Проверьте имя пользователя или пароль", controller: self, completion: ({
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
        registrationView.registrationStack.arrangedSubviews.forEach( { subview in
            if let subview = subview as? UITextField {
                subview.addTarget(self, action: #selector(pressReturn), for: .primaryActionTriggered)
            }
        })
        registrationView.emailPasswordStack.arrangedSubviews.forEach( { subview in
            if let subview = subview as? UITextField {
                subview.addTarget(self, action: #selector(pressReturn), for: .primaryActionTriggered)
            }
        })
        
        //Hide textFields by tap of segmentedControl
        registrationView.registrationSegmentedControl.addTarget(self, action: #selector(chooseSegmentedControl), for: .valueChanged)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let attributes = [NSAttributedString.Key.foregroundColor: ColorsManager.zbzbTextColor.withAlphaComponent(0.5),
                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: attributes)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "")
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
    
    func checkValidation(stack: UIStackView) -> Bool {
        
        var regex: String = ""
        var message = ""
        let titleAlertRegistration = "Ошибка регистрации"
        let signInTitle = "Ошибка входа"
        var title = ""
        
        
        stack.arrangedSubviews.forEach{ subvew in
            if let textField = subvew as? UITextField {
                
                switch textField.textContentType {
                case .emailAddress?:
                    regex = regexForEmail
                case .password?:
                    regex = regexForPassword
                default:
                    break
                }
                
                let text = textField.text ?? ""
                
                switch textField {
                case registrationView.nameTextField:
                    if  text == "" {
                        message = "Введите имя пользователя"
                        title = titleAlertRegistration
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.layer.borderWidth = 0.4
                    }
                case registrationView.emailForRegistrationTextField:
                    title = titleAlertRegistration
                    if  text == "" {
                        message += "\nВведите email"
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.layer.borderWidth = 0.4
                    } else if !text.matches(regex) {
                        message += "\nПроверьте введенный email"
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.layer.borderWidth = 0.4
                    }
                case registrationView.passwordForRegistrationTextField:
                    title = titleAlertRegistration
                    if  text == "" {
                        message += "\nВведите пароль"
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.layer.borderWidth = 0.4
                    } else if !text.matches(regex) {
                        message += "\nПароль должен содержать минимум 6 симфолов, 1 латинский символ и 1 цифру."
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.layer.borderWidth = 0.4
                    }
                case registrationView.confirmPasswordTextField:
                    title = titleAlertRegistration
                    if text != registrationView.passwordForRegistrationTextField.text && registrationView.passwordForRegistrationTextField.text != nil {
                        message += "\nНеверный пароль при подтверждении"
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.layer.borderWidth = 0.4
                    }
                case registrationView.emailTextField:
                    title = signInTitle
                    if  text == "" {
                        message = "Введите email"
                        textField.layer.borderColor = UIColor.red.cgColor
                        textField.layer.borderWidth = 0.4
                    }
                case registrationView.passwordTextField:
                    title = signInTitle
                    if  text == "" {
                        message += "\nВведите пароль"
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
                    if message.contains("Введите имя пользователя") {
                        self.registrationView.nameTextField.becomeFirstResponder()
                    } else if message.contains("Введите email") || message.contains("Проверьте введенный email") {
                        self.registrationView.emailForRegistrationTextField.becomeFirstResponder()
                    } else if message.contains("Введите пароль") || message.contains("Пароль должен содержать минимум 6 симфолов, 1 латинский символ и 1 цифру") {
                        self.registrationView.passwordForRegistrationTextField.becomeFirstResponder()
                    } else if message.contains("Неверный пароль при подтверждении") {
                        self.registrationView.confirmPasswordTextField.becomeFirstResponder()
                    }
                case self.registrationView.emailPasswordStack:
                    if message.contains("Введите email") {
                        self.registrationView.emailTextField.becomeFirstResponder()
                    } else if message.contains("Введите пароль"){
                        self.registrationView.passwordTextField.becomeFirstResponder()
                    }
                default: break
                }
            })
            return false
        }
        return true
    }
    
    func getAlert(title: String?, message: String?, controller: UIViewController?, completion: (() -> Void)? = nil) {
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
