//
//  UITextField.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 9.06.22.
//

import UIKit
import SnapKit

extension UITextField{

    var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }

    var placeHolderSize: UIFont? {
        get {
            return self.placeHolderSize
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.font: newValue])
        }
    }
}


class CustomTextField: UITextField {
    
    var labelPlaceHolder = UILabel()
    
    func addLabelPlaceHolder( text: String, color: UIColor, font: UIFont) {
//        let label = UILabel()
        labelPlaceHolder.text = text
        labelPlaceHolder.textColor = color
        labelPlaceHolder.font = font
        
        self.addSubview(labelPlaceHolder)
        
        labelPlaceHolder.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.centerY.equalToSuperview()
            
        }
    }
    
    func startEditing() {
        labelPlaceHolder.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(2)
            make.centerY.equalToSuperview().offset(-2)
            
        }
        UIView.animate(withDuration: 0.5, delay: .zero, options: .curveLinear) {
            self.layoutIfNeeded()
        }
    }
    
    
    
}
