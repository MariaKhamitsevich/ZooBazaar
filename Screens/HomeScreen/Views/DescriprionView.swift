//
//  DescriprionView.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import UIKit
import SnapKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseStorageUI

final class DescriprionView: UIView {
    
    var productCount: Int = 1 {
        didSet {
            amount.text = String(productCount)
        }
    }
    
    private lazy var productImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var productName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.boldItalic(UIFont.systemFont(ofSize: 20))()
        
        return label
    }()
    
    private lazy var productId: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.boldItalic(UIFont.systemFont(ofSize: 16))()
        
        return label
    }()
    
    private lazy var productPrice: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.boldItalic(UIFont.systemFont(ofSize: 16))()
        
        return label
    }()
    
    private lazy var amountManagerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [decreaseButton, amount, increaseButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        
        return stack
    }()
    
    private(set) lazy var decreaseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowtriangle.backward.fill"), for: .normal)
        button.tintColor = ColorsManager.zbzbTextColor
        button.imageView?.snp.updateConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        button.clipsToBounds = true
        
        
        return button
    }()
    
    private(set) lazy var increaseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        button.tintColor = ColorsManager.zbzbTextColor
        button.imageView?.snp.updateConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        return button
    }()
    
    private(set) lazy var amount: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = ColorsManager.zbzbTextColor
        
        return label
    }()
    
    private lazy var productDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.sizeToFit()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
                
        return label
    }()
    
    private(set) lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorsManager.zbzbTextColor
        button.setTitle("Добавить в корзину", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18).boldItalic()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var currentProduct: Product?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorsManager.unselectedBackgroundColor
        
        addAllSubviews()
        setAllConstraints()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(product: Product) {
        self.productName.text = product.productName
        self.productId.text = "Артикул: " + String(product.productID)
        self.productPrice.text = product.priceForKg
        self.productDescription.text = product.productDescription
        
        let storageRef = Storage.storage().reference()
        let reference = storageRef.child(product.productImageURL)
        reference.downloadURL { url, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                self.productImage.sd_setImage(with: url)
            }
          }
    }
    
    private func addAllSubviews() {
        addSubview(productImage)
        addSubview(productName)
        addSubview(productId)
        addSubview(productPrice)
        addSubview(amountManagerStack)
        addSubview(productDescription)
        addSubview(addToCartButton)
    }
    
    private func setAllConstraints() {
        self.productImage.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(112)
            make.leading.equalTo(self.snp.leading).offset(8)
            make.height.equalTo(UIScreen.main.bounds.height / 3.6)
            make.width.equalTo(UIScreen.main.bounds.height / 6.6)
        }
        self.productName.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.bottom.equalTo(productImage.snp.top)
            make.leading.equalTo(self.snp.leading).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
        }
        self.productId.snp.updateConstraints { make in
            make.top.equalTo(productName.snp.bottom).offset(24)
            make.leading.equalTo(productImage.snp.trailing).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
        }
        self.productPrice.snp.updateConstraints { make in
            make.top.equalTo(productId.snp.bottom).offset(16)
            make.leading.equalTo(productImage.snp.trailing).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
        }
        self.amountManagerStack.snp.updateConstraints { make in
            make.top.equalTo(productPrice.snp.bottom).offset(20)
            make.centerX.equalTo(productPrice.snp.centerX)
        }
        self.amount.snp.updateConstraints { make in
            make.width.equalTo(24)
        }
        self.productDescription.snp.updateConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(16)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.bottom.lessThanOrEqualTo(addToCartButton.snp.top)
        }
        self.addToCartButton.snp.updateConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(UIScreen.main.bounds.width / 4 * 3)
            make.height.equalTo(UIScreen.main.bounds.height * 0.05)
        }
    }
    
    
}
