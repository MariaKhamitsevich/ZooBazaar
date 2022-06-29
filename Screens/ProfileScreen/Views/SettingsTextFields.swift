//
//  SettingsTextFields.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 29.06.22.
//

import UIKit
import SnapKit

struct SettingsContainerView {
    let labelTitle: String
    let firstTextFieldPlaceholder: String
    let secondTextFieldPlaceholder: String?
    let textFieldType: TextFieldType
    
    init(labelTitle: String, firstTextFieldPlaceholder: String, secondTextFieldPlaceholder: String? = nil, textFieldType: TextFieldType) {
        self.labelTitle = labelTitle
        self.firstTextFieldPlaceholder = firstTextFieldPlaceholder
        self.secondTextFieldPlaceholder = secondTextFieldPlaceholder
        self.textFieldType = textFieldType
    }
}

class SettingsTextFields: UIView {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(titleLabel)
        view.addSubview(textFieldStack)
        view.addSubview(confirmButton)
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = ColorsManager.zbzbTextColor
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var textFieldStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstTextField, secondTextField])
        stack.spacing = 12
        stack.axis = .vertical
        
        return stack
    }()

    private(set) lazy var firstTextField: ZBZTextField = {
        let textField = ZBZTextField()
        textField.padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        textField.layer.cornerRadius = 4
        textField.layer.borderColor = ColorsManager.zbzbTextColor.cgColor
        textField.layer.borderWidth = 0.2
        textField.becomeFirstResponder()
        
        
        return textField
    }()
    
    private(set) lazy var secondTextField: ZBZTextField = {
        let textField = ZBZTextField()
        textField.padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        textField.layer.cornerRadius = 4
        textField.layer.borderColor = ColorsManager.zbzbTextColor.cgColor
        textField.layer.borderWidth = 0.2
        textField.isHidden = true
        
        return textField
    }()
    
    private(set) lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(ColorsManager.zbzbTextColor, for: .normal)
        button.backgroundColor = .clear
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorsManager.zbzbBackgroundColor
        backgroundColor = backgroundColor?.withAlphaComponent(0.2)
        
        addAllSubviews()
        setAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func addAllSubviews() {
        self.addSubview(containerView)
    }
    
    private func setAllConstraints() {
        containerView.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(UIScreen.main.bounds.height / 6)
            make.centerX.equalToSuperview()
            make.height.lessThanOrEqualTo(UIScreen.main.bounds.height / 3)
            make.width.equalTo(UIScreen.main.bounds.width * 0.75)
        }
        titleLabel.snp.updateConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(8)
            make.trailing.equalTo(containerView.snp.trailing).offset(-8)
        }
        textFieldStack.snp.updateConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(containerView.snp.leading).offset(8)
            make.trailing.equalTo(containerView.snp.trailing).offset(-8)
            
        }
        textFieldStack.arrangedSubviews.forEach({ $0.snp.updateConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height * 0.04)
        }})
        confirmButton.snp.updateConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.top.equalTo(textFieldStack.snp.bottom).offset(8)
            make.bottom.equalTo(containerView.snp.bottom).offset(-8)
        }
    }
}
