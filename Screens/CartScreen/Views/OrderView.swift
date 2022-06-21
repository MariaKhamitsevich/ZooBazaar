//
//  OrderView.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 21.06.22.
//

import UIKit
import SnapKit

class OrderView: UIView {
    
    let cartManager = CartManager.shared

    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "launchScreen")
        image.alpha = 0.3
        
        
        return image
    }()
    
    private(set) lazy var orderPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Сумма заказа: \(cartManager.countTotalPrice()) руб."
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textColor = ColorsManager.zbzbTextColor
        
        return label
    }()
    
    private lazy var paymentMethodStack: UIStackView = {
        let stack = UIStackView()
        
        return stack
    }()
    
    private lazy var paymentMethodLabel: UILabel = {
        let label = UILabel()
        label.text = "Способ оплаты: "
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textColor = ColorsManager.zbzbTextColor
        
        return label
    }()
    
    private lazy var paymentMethodControl: UIControl = {
        let control = UIControl()

        control.backgroundColor = .red
        
        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorsManager.zbzbBackgroundColor
        
        addAllSubViews()
        setAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addAllSubViews() {
        self.addSubview(logoImageView)
        self.addSubview(orderPriceLabel)
        self.addSubview(paymentMethodControl)
    }
    
    private func setAllConstraints() {
        self.logoImageView.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(-44)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        self.orderPriceLabel.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(32)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(24)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-24)
            make.height.equalTo(24)
        }
        self.paymentMethodControl.snp.updateConstraints { make in
            make.top.equalTo(orderPriceLabel.snp.bottom).offset(32)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(24)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-24)
            make.height.equalTo(24)
        }
    }
}
