//
//  OrderView.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 21.06.22.
//

import UIKit
import SnapKit
import ALRadioButtons
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

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
    
    private(set) lazy var delivaryMethodSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "Доставка", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Самовывоз", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        
        return segmentedControl
    }()
    
    private(set) lazy var deliveryStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [paymentMethodStack, addressTelephoneStack])
        stack.axis = .vertical
        stack.spacing = 20
        
        return stack
    }()
    
    private lazy var paymentMethodStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [paymentMethodLabel, paymentMethodControl])
        stack.axis = .vertical
        stack.spacing = 8
        
        return stack
    }()
    
    private lazy var paymentMethodLabel: UILabel = {
        let label = UILabel()
        label.text = "Способ оплаты: "
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textColor = ColorsManager.zbzbTextColor
        
        return label
    }()
    
    private lazy var paymentMethodControl: ALRadioGroup = {
        let control = ALRadioGroup(items: [.init(title: "Наличные"), .init(title: "Карта")], style: .standard)
        control.selectedIndex = 0
        control.axis = .horizontal
        control.unselectedTitleColor = ColorsManager.unselectedColor
        control.selectedTitleColor = ColorsManager.zbzbTextColor
        control.unselectedIndicatorColor = ColorsManager.unselectedColor
        control.selectedIndicatorColor = ColorsManager.zbzbTextColor
        control.separatorColor = .clear
        control.indicatorRingWidth = 1
        
        return control
    }()
    
    private(set) lazy var addressTelephoneStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [addressTextField, telephoneTextField])
        stack.axis = .vertical
        stack.spacing = 20
        
        return stack
    }()
    
    private(set) lazy var addressTextField: ZBZTextField = {
        let textField = ZBZTextField(image: UIImage(systemName: "house.circle.fill"), placeholder: "Адрес доставки")
        textField.keyboardType = .alphabet
        return textField
    }()
    
    private(set) lazy var telephoneTextField: ZBZTextField = {
        let textField = ZBZTextField(image: UIImage(systemName: "phone.circle.fill"), placeholder: "Номер телефона")
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private(set) lazy var pickupAddressControl: ALRadioGroup = {
        let control = ALRadioGroup(items: [.init(title: "Адрес 1"), .init(title: "Адрес 2"), .init(title: "Адрес 3"), .init(title: "Адрес 4")], style: .standard)
        control.selectedIndex = 0
        control.axis = .vertical
        control.unselectedTitleColor = ColorsManager.unselectedColor
        control.selectedTitleColor = ColorsManager.zbzbTextColor
        control.unselectedIndicatorColor = ColorsManager.unselectedColor
        control.selectedIndicatorColor = ColorsManager.zbzbTextColor
        control.separatorColor = .clear
        control.indicatorRingWidth = 1
        control.isHidden = true
        
        return control
    }()
    
    private(set) lazy var orderingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorsManager.zbzbTextColor
        button.setTitle("Оформить заказ", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        
        return button
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
        self.addSubview(delivaryMethodSegmentedControl)
        self.addSubview(deliveryStack)
        self.addSubview(pickupAddressControl)
        self.addSubview(orderingButton)
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
        self.delivaryMethodSegmentedControl.snp.updateConstraints { make in
            make.top.equalTo(orderPriceLabel.snp.bottom).offset(32)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(24)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-24)
            make.height.equalTo(40)
        }
        self.deliveryStack.snp.updateConstraints { make in
            make.top.equalTo(delivaryMethodSegmentedControl.snp.bottom).offset(32)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(24)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-24)
        }
        self.pickupAddressControl.snp.updateConstraints { make in
            make.top.equalTo(delivaryMethodSegmentedControl.snp.bottom).offset(32)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(24)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-24)
        }
        self.orderingButton.snp.updateConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-24)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width / 3 * 2)
            make.height.equalTo(UIScreen.main.bounds.height * 0.05)
        }
    }
}






