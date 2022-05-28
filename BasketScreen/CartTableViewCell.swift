//
//  CartTableViewCell.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import UIKit
import SnapKit

class CartTableViewCell: UITableViewCell {
    
    private lazy var productImage: UIImageView = {
        let image = UIImageView()
        
        
        return image
    }()
    
    private lazy var productName: UILabel = {
        let label = UILabel()
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var productPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = ColorsManager.zbzbTextColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = ColorsManager.unselectedBackgroundColor.withAlphaComponent(0.5)

        
        contentView.addSubview(productImage)
        contentView.addSubview(productName)
        contentView.addSubview(productPrice)
        
        setAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateValue(product: Product) {
        productName.text = product.name
        productImage.image = product.image
        productPrice.text = product.priceForKg
    }
 
    private func setAllConstraints() {
        self.productImage.snp.updateConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(4)
            make.leading.equalTo(contentView.snp.leading).offset(4)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-4)
            make.height.equalTo(136)
            make.width.equalTo(72)
        }
        self.productName.snp.updateConstraints { make in
            make.top.equalTo(productImage.snp.top)
            make.leading.equalTo(productImage.snp.trailing).offset(4)
            make.trailing.equalTo(contentView.snp.trailing).offset(-4)
        }
        self.productPrice.snp.updateConstraints { make in
            make.top.greaterThanOrEqualTo(productName.snp.bottom).offset(4)
            make.leading.equalTo(productImage.snp.trailing).offset(4)
            make.trailing.equalTo(contentView.snp.trailing).offset(-4)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-4)
        }
    }
}
