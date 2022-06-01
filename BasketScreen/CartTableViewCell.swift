//
//  CartTableViewCell.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import UIKit
import SnapKit

protocol CartTableDataReloading: AnyObject {
    func reload(indexPath: IndexPath?)
}

class CartTableViewCell: UITableViewCell {
    
    var callBack: (() -> Void)?
    var reloadCell: (() -> Void)?
    var reloadTable: (() -> Void)?
    
    private lazy var productImage: UIImageView = {
        let image = UIImageView()
        
        
        return image
    }()
    
    lazy var deleteProductButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "deleteButton"), for: .normal)
        button.imageView?.tintColor = ColorsManager.zbzbTextColor
        button.clipsToBounds = true
        button.imageView?.isUserInteractionEnabled = true
        
        return button
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
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var amountStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [amountName, amountManagerStack])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        
        return stack
    }()
    
    private lazy var amountName: UILabel = {
        let label = UILabel()
        label.text = "Количество, кг"
        label.font = UIFont.systemFont(ofSize: 14).boldItalic()
        label.textColor = ColorsManager.zbzbTextColor
        
        return label
    }()
    
    private lazy var amountManagerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [decreaseButton, amount, increaseButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 4
        
        return stack
    }()
    
    private(set) lazy var decreaseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowtriangle.backward.fill"), for: .normal)
        button.tintColor = ColorsManager.zbzbTextColor
        
        return button
    }()
    
    private(set) lazy var increaseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        button.tintColor = ColorsManager.zbzbTextColor
        
        return button
    }()
    
    private(set) lazy var amount: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = ColorsManager.zbzbTextColor
        
        return label
    }()
    
    var currentProduct: Product?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = ColorsManager.unselectedBackgroundColor.withAlphaComponent(0.5)

        
        contentView.addSubview(productImage)
        contentView.addSubview(productName)
        contentView.addSubview(productPrice)
        contentView.addSubview(deleteProductButton)
        contentView.addSubview(amountStack)
        
        setAllConstraints()
       
        deleteProductButton.addTarget(self, action: #selector(deleteFromCart), for: .touchUpInside)
        decreaseButton.addTarget(self, action: #selector(decreaseAmount), for: .touchUpInside)
        increaseButton.addTarget(self, action: #selector(increaseAmount), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateValue(product: Product, indexPath: IndexPath) {
        productName.text = product.name
        productImage.image = product.image
        productPrice.text = product.priceForKg
        currentProduct = product
        amount.text = String(product.productAmount)

    }
 
    @objc func deleteFromCart() {
//        reloadTable?()
        let cartManager = CartManager.shared
        if let currentProduct = currentProduct {
            cartManager.deleteProduct(product: currentProduct)
        }
        callBack?()
    }
    
    @objc func decreaseAmount() {
        if let currentProduct = currentProduct {
            let cartManager = CartManager.shared
            cartManager.decreaseAmount(product: currentProduct)
        }
        reloadCell?()
    }
    
    @objc func increaseAmount() {
        if let currentProduct = currentProduct {
            let cartManager = CartManager.shared
            cartManager.increaseAmount(product: currentProduct)
        }
        reloadCell?()
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
            make.trailing.equalTo(deleteProductButton.snp.leading).offset(-8)
        }
        self.deleteProductButton.snp.updateConstraints { make in
            make.top.equalTo(productName.snp.top)
            make.trailing.equalTo(contentView.snp.trailing).offset(-4)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        self.productPrice.snp.updateConstraints { make in
            make.top.greaterThanOrEqualTo(productName.snp.bottom).offset(4)
            make.leading.equalTo(productImage.snp.trailing).offset(8)
            make.trailing.equalTo(contentView.snp.trailing).offset(-4)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-4)
        }
        self.amountStack.snp.updateConstraints { make in
            make.top.equalTo(productName.snp.bottom).offset(24)
            make.centerX.equalTo(productName.snp.centerX)
        }
        self.amount.snp.updateConstraints { make in
            make.width.equalTo(24)
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == self.deleteProductButton.imageView {
            return self.deleteProductButton
        }
        
        return view
    }
}
