//
//  OrdersTableViewCell.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 2.07.22.
//

import UIKit
import SnapKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseStorageUI

class OrdersTableViewCell: UITableViewCell {

    private lazy var productImage: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    private lazy var productName: UILabel = {
        let label = UILabel()
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var productPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = ColorsManager.zbzbTextColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private(set) lazy var amount: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textColor = ColorsManager.zbzbTextColor
        
        return label
    }()
    
    private(set) lazy var totalCost: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = ColorsManager.zbzbTextColor
        label.textAlignment = .left
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
    
    func updateValue(product: ProductSettable) {
        productName.text = product.productName
        productPrice.text = "Цена: " + String(product.priceForKg) + " BYN"
        amount.text = "Количество, кг: \(product.productAmount)"
        totalCost.text = "Итого: " + String(product.totalCost) + " BYN"
        
        let storageRef = Storage.storage().reference()
        let reference = storageRef.child(product.productImageURL)
        self.productImage.sd_setImage(with: reference)

    }
    
    private func addAllSubviews() {
        contentView.addSubview(productImage)
        contentView.addSubview(productName)
        contentView.addSubview(productPrice)
        contentView.addSubview(totalCost)
        contentView.addSubview(amount)
    }
    private func setAllConstraints() {
        self.productImage.snp.updateConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(4)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide.snp.centerY)
            make.height.equalTo(75)
            make.width.equalTo(40)
        }
        self.productName.snp.updateConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.equalTo(productImage.snp.trailing).offset(4)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-4)
        }
        self.productPrice.snp.updateConstraints { make in
            make.top.equalTo(amount.snp.bottom).offset(4)
            make.leading.equalTo(productImage.snp.trailing).offset(8)
            make.trailing.equalTo(contentView.snp.trailing).offset(-4)
        }
        self.amount.snp.updateConstraints { make in
            make.top.equalTo(productName.snp.bottom).offset(8)
            make.leading.equalTo(productImage.snp.trailing).offset(8)
            make.trailing.greaterThanOrEqualTo(contentView.snp.trailing).offset(-4)
        }
        self.totalCost.snp.updateConstraints { make in
            make.leading.equalTo(productPrice.snp.leading)
            make.top.equalTo(productPrice.snp.bottom).offset(4)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-8)
            make.trailing.equalTo(contentView.snp.trailing).offset(-4)
        }
    }
}
