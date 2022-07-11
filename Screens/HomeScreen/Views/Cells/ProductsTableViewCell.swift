//
//  CatsProductsTableViewCell.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 1.05.22.
//

import UIKit
import SnapKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseStorageUI

class ProductsTableViewCell: UITableViewCell {
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
                
        return imageView
    }()
    
    private lazy var productStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(productNameLabel)
        stack.addArrangedSubview(productDescription)
        stack.addArrangedSubview(productPriceLabel)
        stack.spacing = 4
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = ColorsManager.zbzbTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var productDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
  
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(productImageView)
        contentView.addSubview(productStackView)
        contentView.isUserInteractionEnabled = true
        contentView.backgroundColor = ColorsManager.zbzbBackgroundColor
        
        setAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateValues(product: Product) {
        productNameLabel.text = product.productName
        productDescription.text = product.productDescription
        productPriceLabel.text = product.priceForKg
        
        let storageRef = Storage.storage().reference()
        let reference = storageRef.child(product.productImageURL)
        reference.downloadURL { url, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                self.productImageView.sd_setImage(with: url)
            }
          }
//        self.productImageView.sd_setImage(with: reference)
    }
    
    private func setAllConstraints() {
        self.productImageView.snp.updateConstraints { make in
            make.top.equalTo(contentView.snp.topMargin).offset(4)
            make.trailing.equalTo(contentView.snp.trailingMargin).offset(-4)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom).offset(-12)
            make.height.equalTo(160)
            make.width.equalTo(90)
        }
        self.productStackView.snp.updateConstraints { make in
            make.top.equalTo(contentView.snp.topMargin).offset(4)
            make.leadingMargin.equalTo(contentView.snp.leadingMargin).offset(8)
            make.trailing.lessThanOrEqualTo(productImageView.snp.leading).offset(-8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }

    }
}
