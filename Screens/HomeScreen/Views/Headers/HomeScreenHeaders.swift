//
//  HomeScreenHeaders.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 5.06.22.
//

import UIKit
import SnapKit

class HomeScreenHeaders: UICollectionReusableView {

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 20).boldItalic()
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
    func setUp(title: String) {
        self.title = title
    }
    
    private func setConstraints() {
        self.headerLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
