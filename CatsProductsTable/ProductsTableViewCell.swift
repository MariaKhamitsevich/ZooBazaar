//
//  CatsProductsTableViewCell.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 1.05.22.
//

import UIKit
import SnapKit





class ProductsTableViewCell: UITableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        productDescription.numberOfLines = 4
    }
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
                
        return imageView
    }()
    private lazy var productStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(productNameLabel)
        stack.addArrangedSubview(productDescription)
        stack.addArrangedSubview(emptyView)
        stack.addArrangedSubview(productPriceLabel)
        stack.addArrangedSubview(productWeightLabels)
        stack.spacing = 4
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.boldSystemFont(ofSize: 20)
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
    
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.snp.updateConstraints { make in
            make.height.greaterThanOrEqualTo(0)
        }
        return view
    }()
    
    //MARK: Weight Labels
    private lazy var productWeightLabels: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(firstWeight)
        stack.addArrangedSubview(secondWeight)
        stack.addArrangedSubview(thirdWeight)
        stack.addArrangedSubview(fourthWeight)
        stack.addArrangedSubview(emptyWeightLabel)
        stack.alignment = .leading
        stack.axis = .horizontal
        stack.spacing = 16
        for label in stack.arrangedSubviews {
            if let label = label as? UILabel {
                label.font = UIFont.systemFont(ofSize: 12)
            }
        }
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    private lazy var firstWeight: UILabel = {
        let label = UILabel()
        label.text = "300 g"
        label.textColor = .purple
        label.tag = 0
        label.isHidden = true
        
        return label
    }()
    private lazy var secondWeight: UILabel = {
        let label = UILabel()
        label.text = "500 g"
        label.textColor = .purple
        label.tag = 1
        label.isHidden = true
        
        return label
    }()
    private lazy var thirdWeight: UILabel = {
        let label = UILabel()
        label.text = "1000 g"
        label.textColor = .purple
        label.tag = 2
        label.isHidden = true
        
        return label
    }()
    private lazy var fourthWeight: UILabel = {
        let label = UILabel()
        label.text = "2000 g"
        label.textColor = .purple
        label.tag = 3
        label.isHidden = true
        
        return label
    }()
    private lazy var emptyWeightLabel: UILabel = {
        let label = UILabel()
        label.tag = 4
        label.snp.updateConstraints { make in
            make.width.greaterThanOrEqualTo(1)
        }
        label.translatesAutoresizingMaskIntoConstraints = false
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
        addDescriptionGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateValues(product: Product) {
        productNameLabel.text = product.name
        productDescription.text = product.description
        productImageView.image = product.image
        productPriceLabel.text = product.priceForKg
        
        for weight in productWeightLabels.arrangedSubviews {
            switch weight.tag {
            case 0:
                weight.isHidden = !product.isFirstweight
            case 1:
                weight.isHidden = !product.isSecondweight
            case 2:
                weight.isHidden = !product.isThirdweight
            case 3:
                weight.isHidden = !product.isFourthweight
            default:
                weight.isHidden = false
            }
        }
        
    }
    
    private func setAllConstraints() {
        self.productImageView.snp.updateConstraints { make in
            make.top.equalTo(contentView.snp.topMargin).offset(4)
            make.trailing.equalTo(contentView.snp.trailingMargin).offset(-4)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom).offset(-12)
            make.height.equalTo(170)
            make.width.equalTo(90)
        }
        self.productStackView.snp.updateConstraints { make in
            make.top.equalTo(contentView.snp.topMargin).offset(4)
            make.leadingMargin.equalTo(contentView.snp.leadingMargin).offset(8)
            make.trailing.lessThanOrEqualTo(productImageView.snp.leading).offset(-8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }

    }
    
    private var isActive: Bool = false
    weak var tableReloadDelegate: TableDataReloading?
    
    private func addDescriptionGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(watchTheDescription))
        productDescription.addGestureRecognizer(gesture)
    }
    
    
    @objc func watchTheDescription(_ gesture: UITapGestureRecognizer) {
        
        isActive.toggle()
        if isActive {
            productNameLabel.numberOfLines = 0
            productDescription.numberOfLines = 0
        } else {
            productNameLabel.numberOfLines = 2
            productDescription.numberOfLines = 4
        }
        tableReloadDelegate?.reload()
    }
}
