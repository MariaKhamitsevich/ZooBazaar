//
//  CartView.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 9.05.22.
//

import UIKit
import SnapKit

final class CartView: UIView {
    
    let cartManager = CartManager.shared
    
    private(set) lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "launchScreen")
        image.alpha = 0.3
        
        
        return image
    }()
    
    private(set) lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Итого: " + String(cartManager.countTotalPrice()) + " BYN"
        label.textAlignment = .left
        label.font = UIFont.boldItalic(UIFont.systemFont(ofSize: 22))()
        label.textColor = ColorsManager.zbzbTextColor
        
        return label
    }()
        
    private(set) lazy var cartTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        
        return table
    }()
    
    private(set) lazy var orderingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorsManager.zbzbTextColor
        button.setTitle("Оформить заказ", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    private(set) lazy var insteadeOfTableLabel: UILabel = {
        let label = UILabel()
        label.text = "Здесь будут размещены Ваши заказы"
        label.textColor = ColorsManager.zbzbTextColor
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 22)
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorsManager.zbzbBackgroundColor
        
        addAllSubvews()
        setAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addAllSubvews() {
        addSubview(logoImageView)
        addSubview(totalPriceLabel)
        addSubview(cartTable)
        addSubview(orderingButton)
        addSubview(insteadeOfTableLabel)
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
            make.height.equalTo(UIScreen.main.bounds.height / 3 * 2)
        }
        self.orderingButton.snp.updateConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-24)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width / 3 * 2.25)
            make.height.equalTo(UIScreen.main.bounds.height * 0.05)
        }
        self.insteadeOfTableLabel.snp.updateConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(32)
            make.trailing.equalTo(self.snp.trailing).offset(-32)
        }
    }
}
