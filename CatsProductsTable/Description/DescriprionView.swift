//
//  DescriprionView.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import UIKit
import SnapKit

class DescriprionView: UIView {
    
    private lazy var productImage: UIImageView = {
        let image = UIImageView()
        
        
        return image
    }()
    
    private lazy var productName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.boldItalic(UIFont.systemFont(ofSize: 26))()
        
        return label
    }()
    
    private lazy var productId: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.boldItalic(UIFont.systemFont(ofSize: 16))()
        
        return label
    }()
    
    private lazy var productPrice: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.boldItalic(UIFont.systemFont(ofSize: 16))()
        
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
        
        addSubview(productImage)
        addSubview(productName)
        addSubview(productId)
        addSubview(productPrice)
        addSubview(productDescription)
        addSubview(addToCartButton)

        
        setAllConstraints()
        

    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(product: Product) {
        self.productName.text = product.name
        self.productId.text = "Артикул: " + product.productID
        self.productPrice.text = product.priceForKg
        self.productImage.image = product.image
        self.productDescription.text = product.description
    }
    
    private func setAllConstraints() {
        self.productImage.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(112)
            make.leading.equalTo(self.snp.leading).offset(8)
            make.height.equalTo(UIScreen.main.bounds.height / 3)
            make.width.equalTo(UIScreen.main.bounds.width / 2.5)
        }
        self.productName.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.bottom.equalTo(productImage.snp.top)
            make.leading.equalTo(self.snp.leading).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
        }
        self.productId.snp.updateConstraints { make in
            make.top.equalTo(productName.snp.bottom).offset(16)
            make.leading.equalTo(productImage.snp.trailing).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
        }
        self.productPrice.snp.updateConstraints { make in
            make.top.equalTo(productId.snp.bottom).offset(16)
            make.leading.equalTo(productImage.snp.trailing).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
        }
        self.productDescription.snp.updateConstraints { make in
            make.top.equalTo(productImage.snp.bottom)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        self.addToCartButton.snp.updateConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(UIScreen.main.bounds.width / 4 * 3)
            make.height.equalTo(UIScreen.main.bounds.height * 0.05)
        }
    }
    
    
}
