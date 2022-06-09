//
//  ProfileView.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 16.05.22.
//

import UIKit
import SnapKit

protocol ProfileDataSettable: AnyObject {
    func setEmail(email: String)
    func setName(name: String)
}

class ProfileView: UIView {
    
    private lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Профиль"
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.italicSystemFont(ofSize: 20)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "emptyProfile")
        image.backgroundColor = ColorsManager.zbzbBackgroundColor
        
        return image
    }()
    
    private lazy var nameStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(emailLabel)
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 16
        
        return stack
    }()
    
     private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = UserDefaults.standard.string(forKey: "UserName")
        
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = UserDefaults.standard.string(forKey: "UserEmail")

        return label
    }()
    
    lazy var exitButton: UIButton = {
        let button = UIButton()
        let title = "Выйти из профиля"
        button.setTitle(title, for: .normal)
        button.setTitleColor(ColorsManager.zbzbTextColor, for: .normal)
        button.backgroundColor = .clear
        
        let font = UIFont.italicSystemFont(ofSize: 16)
        let attributedSring = NSMutableAttributedString(string: title)
        let range = NSRange(location: 0, length: title.count)

//        attributedSring.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
//        attributedSring.addAttribute(.font, value: font, range: range)
        attributedSring.addAttributes([.underlineStyle : NSUnderlineStyle.single.rawValue, .font : font], range: range)
        button.titleLabel?.attributedText = attributedSring

        return button
    }()
    
    

//    MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorsManager.zbzbBackgroundColor
        addSubview(profileLabel)
        addSubview(profileImage)
        addSubview(nameStack)
        addSubview(exitButton)
        
        setAllConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setEmail(email: String) {
//            emailLabel.text = email
//    }
//
//    func setName(name: String) {
//            nameLabel.text = name
//    }
    
//  MARK: Constraints
    private func setAllConstraints() {
        self.profileLabel.snp.updateConstraints { make in
            make.top.equalTo(self.snp.topMargin).offset(24)
            make.centerX.equalTo(self.snp.centerX)
        }
        self.profileImage.snp.updateConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(24)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        self.nameStack.snp.updateConstraints { make in
            make.top.equalTo(profileImage.snp.top).offset(16)
            make.leading.equalTo(profileImage.snp.trailing).offset(24)
            make.trailing.equalToSuperview().offset(-16)
        }
        self.exitButton.snp.updateConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(24)
            make.leading.equalTo(self.snp.leading).offset(16)
        }
    }
}





