//
//  SettingsTextFieldsViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 29.06.22.
//

import UIKit
import FirebaseAuth
import FirebaseCore

enum TextFieldType {
    case name
    case address
    case email
    case password
    
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
        }
    }
}

class SettingsTextFieldsViewController: UIViewController, UITextFieldDelegate {
    
    var textFieldType: TextFieldType = .name
    var actionOnTextField: (() -> Void)?
    
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
        // Do any additional setup after loading the view.
        
        addAllTargets()
    }

    func updateData(data: SettingsContainerView) {
        settingsView.titleLabel.text = data.labelTitle
        settingsView.firstTextField.placeholder = data.firstTextFieldPlaceholder
        self.textFieldType = data.textFieldType
        
        if let secondPlaceholder = data.secondTextFieldPlaceholder {
            settingsView.secondTextField.isHidden = false
            settingsView.secondTextField.placeholder = secondPlaceholder
        } else {
            settingsView.secondTextField.isHidden = true
        }
    }
    
    func addAllTargets() {
        settingsView.confirmButton.addTarget(self, action: #selector(nameTextFieldAction), for: .touchUpInside)
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
                } else {
                    self.dismiss(animated: false)
                }
            }
        } else {
            let alert = ZBZAlert(title: nil, message: "Введите имя", preferredStyle: .alert)
            alert.getAlert(controller: self)
        }
    }
}
