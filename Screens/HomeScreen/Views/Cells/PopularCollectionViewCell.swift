//
//  PopularCollectionViewCell.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 5.06.22.
//

import UIKit
import SnapKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseStorageUI

class PopularCollectionViewCell: UICollectionViewCell {
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
                
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .left
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textColor = ColorsManager.zbzbTextColor
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productPriceLabel)
        contentView.backgroundColor = .clear
        
        setAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateValues(product: Product) {
        productNameLabel.text = product.productName
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
    }
    
    private func setAllConstraints() {
        self.productImageView.snp.updateConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(2)
            make.height.equalTo(UIScreen.main.bounds.width / 2 - 40)
            make.width.equalTo((UIScreen.main.bounds.width / 2 - 24) / 2)
        }
        self.productNameLabel.snp.updateConstraints { make in
            make.top.equalTo(productImageView.snp.top).offset(8)
            make.leading.equalTo(productImageView.snp.trailing).offset(2)
            make.trailing.equalToSuperview().offset(-2)
        }
        self.productPriceLabel.snp.updateConstraints { make in
            make.top.greaterThanOrEqualTo(productNameLabel.snp.bottom).offset(16)
            make.bottom.equalTo(productImageView.snp.bottom).offset(-8)
            make.leading.equalTo(productNameLabel.snp.leading)
            make.trailing.equalTo(productNameLabel.snp.trailing)
        }
    }
}
