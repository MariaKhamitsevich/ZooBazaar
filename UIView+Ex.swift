//
//  UIView.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 13.06.22.
//

import UIKit

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder!.next
        }
        return nil
    }
}
