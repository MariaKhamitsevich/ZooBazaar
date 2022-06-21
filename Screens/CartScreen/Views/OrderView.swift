//
//  OrderView.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 21.06.22.
//

import UIKit

class OrderView: UIView {

    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "launchScreen")
        image.alpha = 0.3
        
        
        return image
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
    }
    private func setAllConstraints() {
        self.logoImageView.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
