//
//  UITextField.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 9.06.22.
//

import UIKit
import SnapKit

extension UITextField {

    var placeHolderColor: UIColor? {
        get {
            return nil
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue ?? self.placeHolderColor ?? ""])
        }
    }

    var placeHolderSize: UIFont? {
        get {
            return nil
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.font: newValue ?? self.placeHolderSize ?? ""])
        }
    }
}


class ZBZTextField: UITextField {

    var padding = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
    let leftImage = UIImageView()

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(image: UIImage?, placeholder: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        backgroundColor = .white
        self.leftImage.image = image
        self.leftImage.tintColor = ColorsManager.zbzbTextColor
        self.addSubview(leftImage)
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: ColorsManager.zbzbTextColor.withAlphaComponent(0.5)])
        textColor = ColorsManager.zbzbTextColor
        layer.cornerRadius = 8
        leftViewMode = .always
        layer.borderColor = ColorsManager.zbzbTextColor.cgColor
        layer.borderWidth = 0.2
        self.snp.updateConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height * 0.04)
        }
        self.leftImage.snp.updateConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.03)
            make.width.equalTo(UIScreen.main.bounds.height * 0.03)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
