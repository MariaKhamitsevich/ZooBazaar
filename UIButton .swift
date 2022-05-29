//
//  Button animate.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 29.05.22.
//

import UIKit
import SnapKit

extension UIButton {

func animateButtonTap(view: UIView, startWidth: Double, startHeight: Double) {
    UIView.animate(withDuration: 0.1, delay: .zero, options: .curveLinear, animations: {
       self.snp.updateConstraints { make in
            make.height.equalTo(startHeight * 0.95)
            make.width.equalTo(startWidth * 0.98)
        }
        view.layoutIfNeeded()
    }, completion: {_ in
        UIView.animate(withDuration: 0.1, delay: .zero, options: .curveLinear) {
            self.snp.updateConstraints { make in
                make.height.equalTo(startHeight)
                make.width.equalTo(startWidth)
            }
            view.layoutIfNeeded()
        }
        
    }
    )
}
}
