//
//  ProfileView.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 9.05.22.
//

import UIKit
import SnapKit

class RegistrationView: UIView {
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "launchScreen")
        image.alpha = 0.3
        
        
        return image
    }()
    
    private(set) lazy var registrationSegmentedControl: UISegmentedControl = {
        var segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "Вход", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Регистрация", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        
        return segmentedControl
    }()
    
    private(set) lazy var emailPasswordStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(passwordTextField)
        stack.axis = .vertical
        stack.spacing = 20
        
        
        return stack
    }()
    
    private(set) lazy var emailTextField: ZBZTextField = {
        let textField = ZBZTextField(image: UIImage(systemName: "envelope.circle.fill"), placeholder: "Email")
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.textContentType = .emailAddress
        
        return textField
    }()
    
    private(set) lazy var passwordTextField: ZBZTextField = {
        let textField = ZBZTextField(image: UIImage(systemName: "key.fill"), placeholder: "Пароль")
        textField.keyboardType = .numbersAndPunctuation
        textField.returnKeyType = .done
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private(set) lazy var registrationStack: UIStackView = {
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
    
    private(set) lazy var nameTextField: ZBZTextField = {
        let textField =  ZBZTextField(image: UIImage(systemName: "person.circle.fill"), placeholder: "Имя")
        textField.keyboardType = .alphabet
        textField.returnKeyType = .done
        
        return textField
    }()
    
    private(set) lazy var emailForRegistrationTextField: ZBZTextField = {
        let textField = ZBZTextField(image: UIImage(systemName: "envelope.circle.fill"), placeholder: "Email")
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.textContentType = .emailAddress
        
        return textField
    }()
    
    private(set) lazy var passwordForRegistrationTextField: ZBZTextField = {
        let textField = ZBZTextField(image: UIImage(systemName: "key.fill"), placeholder: "Пароль")
        textField.keyboardType = .numbersAndPunctuation
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private(set) lazy var confirmPasswordTextField: ZBZTextField = {
        let textField = ZBZTextField(image: UIImage(systemName: "key.fill"), placeholder: "Подтвердите пароль")
        textField.keyboardType = .numbersAndPunctuation
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        
        
        return textField
    }()
    
   private(set) lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorsManager.zbzbTextColor
        button.setTitle("Вход", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.gray, for: .disabled)
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    private(set) lazy var rememberLabel: UILabel = {
        let label = UILabel()
        label.text = "Забыли пароль?"
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.italicSystemFont(ofSize: 16)
        
        return label
    }()
    
   private(set) lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorsManager.zbzbTextColor
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.isHidden = true
        
        return button
    }()
    
    
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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




