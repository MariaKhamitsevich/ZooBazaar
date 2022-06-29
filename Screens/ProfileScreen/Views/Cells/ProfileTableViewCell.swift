//
//  ProfileTableViewCell.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 28.06.22.
//

import UIKit
import SnapKit

class ProfileTableViewCell: UITableViewCell {

    private(set) lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = ColorsManager.zbzbTextColor
        
        return image
    }()
    
    private(set) lazy var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.boldItalic(UIFont.systemFont(ofSize: 18))()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addAllSubviews()
        setAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(data: ProfileTableData) {
        self.image.image = data.image
        self.title.text = data.title
    }
    
    private func addAllSubviews() {
        contentView.addSubview(image)
        contentView.addSubview(title)
    }
    
    private func setAllConstraints() {
        image.snp.updateConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(16)
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(12)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-12)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        title.snp.updateConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(4)
            make.trailing.lessThanOrEqualTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-4)
            make.centerY.equalTo(image.snp.centerY)
        }
    }
}


struct ProfileTableData {
    let title: String
    let image: UIImage
}
