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

class ProfileView: UIView, ProfileDataSettable {
    
    let profileAvatarPlaceholder: UIImage = UIImage(named: "emptyProfile") ?? UIImage()
    let imageSize = CGSize(width: 120, height: 120)
  
    
    private(set) lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = profileAvatarPlaceholder
        image.backgroundColor = ColorsManager.zbzbBackgroundColor
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.layer.cornerRadius = imageSize.height / 2
        
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
        label.font = UIFont.italicSystemFont(ofSize: 22)
        label.textAlignment = .left
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.italicSystemFont(ofSize: 18)
        label.textAlignment = .left

        return label
    }()
    
    private(set) lazy var profileTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.isScrollEnabled = false
        
        return table
    }()
        

//    MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorsManager.zbzbBackgroundColor
        addSubview(profileImage)
        addSubview(nameStack)
        addSubview(profileTable)
        
        setAllConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setEmail(email: String) {
            emailLabel.text = email
    }

    func setName(name: String) {
            nameLabel.text = name
    }
    
//  MARK: Constraints
    private func setAllConstraints() {

        self.profileImage.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(24)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.height.equalTo(imageSize.height)
            make.width.equalTo(imageSize.width)
        }
        self.nameStack.snp.updateConstraints { make in
            make.top.equalTo(profileImage.snp.top).offset(16)
            make.leading.equalTo(profileImage.snp.trailing).offset(24)
            make.trailing.equalToSuperview().offset(-16)
        }
        self.profileTable.snp.updateConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(24)
            make.leading.equalTo(self.snp.leading).offset(4)
            make.trailing.equalTo(self.snp.trailing).offset(-4)
            make.bottom.equalToSuperview()
        }
    }
}





