//
//  Button animate.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 29.05.22.
//

import UIKit
import SnapKit

extension UIButton {
    
    func animateButtonTap(startWidth: Double, startHeight: Double, completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.1, delay: .zero, options: .curveLinear, animations: {
            self.snp.updateConstraints { make in
                make.height.equalTo(startHeight * 0.95)
                make.width.equalTo(startWidth * 0.98)
            }
            if let view = self.superview {
                view.layoutIfNeeded()
            }
        }, completion: {_ in
            UIView.animate(withDuration: 0.1, delay: .zero, options: .curveLinear, animations:  {
                self.snp.updateConstraints { make in
                    make.height.equalTo(startHeight)
                    make.width.equalTo(startWidth)
                }
                if let view = self.superview {
                    view.layoutIfNeeded()
                }
            }, completion: completion)
            
        }
        )
    }
}





final class ButtonWithTouchSize: UIButton {
    var touchAreaPadding: UIEdgeInsets?
    override func point(inside point: CGPoint,
                        with event: UIEvent?) -> Bool
    {
        guard let insets = touchAreaPadding else {
            return super.point(inside: point, with: event)
        }
        let rect = bounds.inset(by: insets.inverted())
        return rect.contains(point)
    }
}

extension UIEdgeInsets {
    
    func inverted() -> UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left,
                            bottom: -bottom, right: -right)
    }
}
