//
//  MapsView.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 9.05.22.
//

import UIKit
import SnapKit

class MapsView: UIView {
    
    private(set) lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorsManager.zbzbTextColor
        button.setTitle("Таблица", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18).boldItalic()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorsManager.zbzbBackgroundColor
        addSubview(addToCartButton)
        setAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setAllConstraints() {
        self.addToCartButton.snp.updateConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(UIScreen.main.bounds.width / 4 * 3)
            make.height.equalTo(UIScreen.main.bounds.height * 0.05)
        }
    }
}
