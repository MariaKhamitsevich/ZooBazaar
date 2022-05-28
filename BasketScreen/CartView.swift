//
//  CartView.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 9.05.22.
//

import UIKit
import SnapKit

class CartView: UIView {
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "launchScreen")
        image.alpha = 0.3
        
        
        return image
    }()
    
    private lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Итого"
        label.textAlignment = .left
        label.font = UIFont.boldItalic(UIFont.systemFont(ofSize: 22))()
        label.textColor = ColorsManager.zbzbTextColor
        
        return label
    }()
    
     lazy var cartTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorsManager.zbzbBackgroundColor
        addSubview(logoImageView)
        addSubview(totalPriceLabel)
        addSubview(cartTable)
        
        setAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setAllConstraints() {
        self.logoImageView.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        self.totalPriceLabel.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(self.snp.leading).offset(8)
        }
        self.cartTable.snp.updateConstraints { make in
            make.top.equalTo(totalPriceLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.snp.leading).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
            make.height.equalTo(UIScreen.main.bounds.height / 2)
        }
    }
}
