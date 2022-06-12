//
//  ProfileView.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 9.05.22.
//

import UIKit
import SnapKit

class RegistrationView: UIView, UITextFieldDelegate {
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "launchScreen")
        image.alpha = 0.3
        
        
        return image
    }()
    
    private lazy var registrationSegmentedControl: UISegmentedControl = {
        var segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "Вход", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Регистрация", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0

                
        return segmentedControl
    }()
    
    private lazy var emailPasswordStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(passwordTextField)
        
        stack.axis = .vertical
        stack.spacing = 20
        
        
        return stack
    }()
    
    private(set) lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: " Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)])
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.backgroundColor = .white
        textField.textColor = ColorsManager.zbzbTextColor
        textField.layer.cornerRadius = 4
        textField.returnKeyType = .done
        textField.textContentType = .emailAddress
//        textField.enablesReturnKeyAutomatically = true
        
        return textField
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: " Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)])
        textField.keyboardType = .numbersAndPunctuation
        textField.backgroundColor = .white
        textField.textColor = ColorsManager.zbzbTextColor
        textField.layer.cornerRadius = 4
        textField.returnKeyType = .done
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private lazy var registrationStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(nameTextField)
        stack.addArrangedSubview(emailForRegistrationTextField)
        stack.addArrangedSubview(passwordForRegistrationTextField)
        stack.addArrangedSubview(confirmPasswordTextField)
     
        stack.axis = .vertical
        stack.spacing = 20
        
        stack.isHidden = true
        
        return stack
    }()
    
    private(set) lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: " Имя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)])
        textField.keyboardType = .alphabet
        textField.backgroundColor = .white
        textField.textColor = ColorsManager.zbzbTextColor
        textField.layer.cornerRadius = 4
        textField.returnKeyType = .done
        textField.tag = 0
        textField.textContentType = .nickname
        
        return textField
    }()
    
    private(set) lazy var emailForRegistrationTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: " Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)])
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.backgroundColor = .white
        textField.textColor = ColorsManager.zbzbTextColor
        textField.layer.cornerRadius = 4
        textField.returnKeyType = .done
        textField.tag = 1
        textField.textContentType = .emailAddress
        
        return textField
    }()
    
    private(set) lazy var passwordForRegistrationTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: " Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)])
        textField.keyboardType = .numbersAndPunctuation
        textField.backgroundColor = .white
        textField.textColor = ColorsManager.zbzbTextColor
        textField.layer.cornerRadius = 4
        textField.returnKeyType = .done
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        
        
        return textField
    }()
    
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: " Подтвердите пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)])
        textField.keyboardType = .numbersAndPunctuation
        textField.backgroundColor = .white
        textField.textColor = ColorsManager.zbzbTextColor
        textField.layer.cornerRadius = 4
        textField.returnKeyType = .done
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        
        
        return textField
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorsManager.zbzbTextColor
        button.setTitle("Вход", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    private lazy var rememberLabel: UILabel = {
        let label = UILabel()
        label.text = "Забыли пароль?"
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.italicSystemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorsManager.zbzbTextColor
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.isHidden = true
        
        return button
    }()
    
    
    var name = ""
    var email = ""
    private let regexForPassword = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
    private let regexForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    //    "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$&*])[A-Za-z\\d!@#$&*]{6,}$"
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorsManager.zbzbBackgroundColor
        addSubview(logoImageView)
        addSubview(registrationSegmentedControl)
        addSubview(emailPasswordStack)
        addSubview(registrationStack)
        addSubview(confirmButton)
        addSubview(rememberLabel)
        addSubview(registrationButton)
        
        
        
        setAllConstraints()
        addAllTargets()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Add all targets
    private func addAllTargets() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
        emailForRegistrationTextField.delegate = self
        passwordForRegistrationTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        //Added target on return button
        registrationStack.arrangedSubviews.forEach( { subview in
            if let subview = subview as? UITextField {
                subview.addTarget(self, action: #selector(pressReturn), for: .primaryActionTriggered)
            }
        })
        emailPasswordStack.arrangedSubviews.forEach( { subview in
            if let subview = subview as? UITextField {
                subview.addTarget(self, action: #selector(pressReturn), for: .primaryActionTriggered)
            }
        })
        
        //Save data for email and name
        nameTextField.addTarget(self, action: #selector(setName(_:)), for: .editingChanged)
        emailForRegistrationTextField.addTarget(self, action: #selector(setEmail(_:)), for: .editingChanged)
        
        
        //Choose textField and change it's placeholder
        NotificationCenter.default.addObserver(self, selector: #selector(startEditing), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //Hide textFields by tap of segmentedControl
        registrationSegmentedControl.addTarget(self, action: #selector(chooseSegmentedControl), for: .valueChanged)
    }

    @objc func startEditing() {
        
        let attributes = [NSAttributedString.Key.foregroundColor: ColorsManager.zbzbTextColor.withAlphaComponent(0.5),
                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        
        func setupSubviewsPlaceholder(for stack: UIStackView) {
            stack.arrangedSubviews.forEach( { subview in
                if let subview = subview as? UITextField {
                    if subview.isFirstResponder {
                        subview.attributedPlaceholder = NSAttributedString(string: subview.placeholder ?? "", attributes: attributes)
                    } else {
                        subview.attributedPlaceholder = NSAttributedString(string: subview.placeholder ?? "")
                    }
                }
            })
        }
        
        setupSubviewsPlaceholder(for: emailPasswordStack)
        setupSubviewsPlaceholder(for: registrationStack)
    }
                                                    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func pressReturn() {
        self.endEditing(true)
        
        func setupSubviewsPlaceholder(for stack: UIStackView) {
            stack.arrangedSubviews.forEach( { subview in
                if let subview = subview as? UITextField {
                    subview.attributedPlaceholder = NSAttributedString(string: subview.placeholder ?? "")
                }
            })
        }
        setupSubviewsPlaceholder(for: emailPasswordStack)
        setupSubviewsPlaceholder(for: registrationStack)
    }
    
    @objc private func chooseSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            emailPasswordStack.isHidden = false
            confirmButton.isHidden = false
            rememberLabel.isHidden = false
            registrationStack.isHidden = true
            registrationButton.isHidden = true
        case 1:
            emailPasswordStack.isHidden = true
            confirmButton.isHidden = true
            rememberLabel.isHidden = true
            registrationStack.isHidden = false
            registrationButton.isHidden = false
            
        default:
            registrationStack.isHidden = true
        }
    }
    
    @objc private func setName(_ sender: UITextField) {
        if let text = sender.text {
            self.name = text
        }
    }
    @objc private func setEmail(_ sender: UITextField) {
        if let text = sender.text {
            self.email = text
        }
    }
    
    //   MARK: Constraints
    private func setAllConstraints() {
        self.logoImageView.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.registrationSegmentedControl.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(48)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        self.emailPasswordStack.snp.updateConstraints { make in
            make.top.equalTo(registrationSegmentedControl.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        self.registrationStack.snp.updateConstraints { make in
            make.top.equalTo(registrationSegmentedControl.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        self.registrationStack.arrangedSubviews.forEach({ $0.snp.updateConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height * 0.04)
        }})
        self.emailPasswordStack.arrangedSubviews.forEach({ $0.snp.updateConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height * 0.04)
        }})
        self.confirmButton.snp.updateConstraints { make in
            make.top.equalTo(emailPasswordStack.snp.bottom).offset(20)
            make.centerX.equalTo(emailPasswordStack.snp.centerX)
            make.width.equalTo(UIScreen.main.bounds.width / 3 * 2)
            make.height.equalTo(UIScreen.main.bounds.height * 0.05)
        }
        self.rememberLabel.snp.updateConstraints { make in
            make.top.equalTo(confirmButton.snp.bottom).offset(16)
            make.centerX.equalTo(emailPasswordStack.snp.centerX)
        }
        self.registrationButton.snp.updateConstraints { make in
            make.top.equalTo(registrationStack.snp.bottom).offset(20)
            make.centerX.equalTo(registrationStack.snp.centerX)
            make.width.equalTo(UIScreen.main.bounds.width / 3 * 2)
            make.height.equalTo(UIScreen.main.bounds.height * 0.05)
        }
    }
    
}

extension RegistrationView {
    
    private func checkValidation(textField: UITextField) {
        var regex: String = ""
        switch textField.textContentType {
        case .emailAddress?: regex = regexForEmail
        case .password?: regex = regexForPassword
        default: return
        }
            
        if let text = textField.text {
            if text.matches(regex) {
            confirmButton.isUserInteractionEnabled = true
            registrationButton.isUserInteractionEnabled = true
            } else {
                confirmButton.isUserInteractionEnabled = false
                registrationButton.isUserInteractionEnabled = false
            }
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") + string
        let res: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            res = String(text[text.startIndex..<end])
        } else {
            res = text
        }
        
        checkValidation(textField: textField)
        textField.text = res
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
