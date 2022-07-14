//
//  ProductsTableHeaderView.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 3.05.22.
//

import UIKit
import SnapKit

final class ProductsTableHeaderView: UIView {

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = ColorsManager.zbzbTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var title: String? {
        get {
            headerLabel.text
        }
        set{
            headerLabel.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        self.headerLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
