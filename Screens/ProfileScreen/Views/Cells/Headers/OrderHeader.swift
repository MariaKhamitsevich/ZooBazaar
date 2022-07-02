//
//  OrderHeader.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 2.07.22.
//

import Foundation
import SnapKit

class OrderHeader: UICollectionReusableView {

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
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
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-4)
        }
    }
}
