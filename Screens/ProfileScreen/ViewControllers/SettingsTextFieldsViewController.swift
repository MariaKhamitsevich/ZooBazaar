//
//  SettingsTextFieldsViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 29.06.22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

enum TextFieldType {
    case name
    case address
    case email
    case password
    case phone
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .name:
            return .alphabet
        case .address:
            return .alphabet
        case .email:
            return .emailAddress
        case .password:
            return .numbersAndPunctuation
        case .phone:
            return .phonePad
        }
    }
}

final class SettingsTextFieldsViewController: UIViewController, UITextFieldDelegate {
    
    var textFieldType: TextFieldType = .name
    
    private var settingsView: SettingsTextFields {
        view as! SettingsTextFields
    }
    
    override func loadView() {
        self.view = SettingsTextFields()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.firstTextField.delegate = self
        settingsView.secondTextField.delegate = self
        
        addAllTargets()
    }

    func updateData(data: SettingsContainerView) {
        settingsView.titleLabel.text = data.labelTitle
        settingsView.firstTextField.placeholder = data.firstTextFieldPlaceholder
        self.textFieldType = data.textFieldType
        settingsView.firstTextField.keyboardType = data.textFieldType.keyboardType
        
        if let secondPlaceholder = data.secondTextFieldPlaceholder {
            settingsView.secondTextField.isHidden = false
            settingsView.secondTextField.placeholder = secondPlaceholder
        } else {
            settingsView.secondTextField.isHidden = true
        }
        
        switch data.textFieldType {
        case .name:
            settingsView.confirmButton.addTarget(self, action: #selector(nameTextFieldAction), for: .touchUpInside)
        case .address:
            settingsView.confirmButton.addTarget(self, action: #selector(addressTextFieldAction), for: .touchUpInside)
        case .email:
            settingsView.confirmButton.addTarget(self, action: #selector(emailTextFieldAction), for: .touchUpInside)
        case .password:
            settingsView.confirmButton.addTarget(self, action: #selector(passwordTextFieldAction), for: .touchUpInside)
        case .phone:
            settingsView.confirmButton.addTarget(self, action: #selector(phoneTextFieldAction), for: .touchUpInside)
        }
    }
    
  private func addAllTargets() {
//        settingsView.confirmButton.addTarget(self, action: #selector(nameTextFieldAction), for: .touchUpInside)
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
    
   @objc func nameTextFieldAction(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        let userChange = user?.createProfileChangeRequest()
        
       if settingsView.firstTextField.text != "" {
           let text = settingsView.firstTextField.text
            userChange?.displayName = text
            userChange?.commitChanges() { error in
                if let error = error {
                    print("Name change error: \(error)")
                    let alert = ZBZAlert(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                    alert.getAlert(controller: self)
                } else {
                    self.dismiss(animated: true)
                }
            }
        } else {
            let alert = ZBZAlert(title: nil, message: "?????????????? ??????", preferredStyle: .alert)
            alert.getAlert(controller: self)
        }
    }
    
    @objc func addressTextFieldAction(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        
        if settingsView.firstTextField.text != "" {
            let text = settingsView.firstTextField.text ?? ""
            let db = Firestore.firestore()
            if let uid = user?.uid {
                db.collection("UserAddresses").document(uid).setData(["UserAddress" : text]) { [weak self] error in
                    if let error = error {
                        Swift.debugPrint(error.localizedDescription)
                    } else {
                        self?.dismiss(animated: false)
                    }
                }
            }
        } else {
            let alert = ZBZAlert(title: nil, message: "?????????????? ??????????", preferredStyle: .alert)
            alert.getAlert(controller: self)
        }
    }
    
    @objc func phoneTextFieldAction(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        
        if settingsView.firstTextField.text != "" {
            if checkValidation(regex: .phone, text: settingsView.firstTextField.text ?? "") {
                let text = settingsView.firstTextField.text ?? ""
                let db = Firestore.firestore()
                if let uid = user?.uid {
                    db.collection("UserPhone").document(uid).setData(
                        ["UserPhoneNumber" : text]) { [weak self] error in
                            if let error = error {
                                Swift.debugPrint(error.localizedDescription)
                            } else {
                                self?.dismiss(animated: false)
                            }
                        }
                    }
                } else {
                    let alert = ZBZAlert(title: nil, message: "?????????????????? ?????????????????? ??????????", preferredStyle: .alert)
                    alert.getAlert(controller: self)
                }
            }  else {
                let alert = ZBZAlert(title: nil, message: "?????????????? ?????????? ????????????????", preferredStyle: .alert)
                alert.getAlert(controller: self)
            }
    }
    
    @objc func emailTextFieldAction(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        
        if settingsView.firstTextField.text != "" {
            if checkValidation(regex: .email, text: settingsView.firstTextField.text ?? "") {
                let text = settingsView.firstTextField.text ?? ""
                user?.updateEmail(to: text, completion: { error in
                    if let error = error {
                        print("Email change error: \(error)")
                        let alert = ZBZAlert(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                        alert.getAlert(controller: self)
                    } else {
                        self.dismiss(animated: false)
                    }
                })
            }
            else {
                let alert = ZBZAlert(title: nil, message: "?????????????????? ?????????????????? email", preferredStyle: .alert)
                alert.getAlert(controller: self)
            }
        }
        else {
            let alert = ZBZAlert(title: nil, message: "?????????????? email", preferredStyle: .alert)
            alert.getAlert(controller: self)
        }
    }
    
    @objc func passwordTextFieldAction(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        
        if settingsView.firstTextField.text == "" && settingsView.secondTextField.text == "" {
            let alert = ZBZAlert(title: nil, message: "?????????????? ?????????? ????????????", preferredStyle: .alert)
            alert.getAlert(controller: self)
        }
        else if settingsView.secondTextField.text == "" {
            let alert = ZBZAlert(title: nil, message: "?????????????????????? ????????????", preferredStyle: .alert)
            alert.getAlert(controller: self)}
        else if settingsView.firstTextField.text != settingsView.secondTextField.text {
            
            let alert = ZBZAlert(title: nil, message: "?????????????????? ?????????????????? ????????????", preferredStyle: .alert)
            alert.getAlert(controller: self)
        }
        else if settingsView.firstTextField.text != "" {
            if checkValidation(regex: .password, text: settingsView.firstTextField.text ?? "") {
           let text = settingsView.firstTextField.text ?? ""
           user?.updatePassword(to: text, completion: { error in
                if let error = error {
                    print("Password change error: \(error)")
                    let alert = ZBZAlert(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                    alert.getAlert(controller: self)
                } else {
                    self.dismiss(animated: false)
                }
            })
            } else {
                let alert = ZBZAlert(title: nil, message: "?????????????????? ?????????????????? ????????????: \n???????????? ???????????? ?????????????????? ?????????????? 6 ????????????????, 1 ?????????????????? ???????????? ?? 1 ??????????", preferredStyle: .alert)
                alert.getAlert(controller: self)
            }
       }
        
    }
    
  private func checkValidation(regex: RegexType, text: String) -> Bool {
        let regex: RegexType = regex
        if text.matches(regex.rawValue) {
            return true
        }
        return false
    }
}
