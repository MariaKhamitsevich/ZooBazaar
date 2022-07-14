//
//  Alert.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 29.06.22.
//

import Foundation
import UIKit


final class ZBZAlert: UIAlertController {
    
    func getAlert(controller: UIViewController?, completion: (() -> Void)? = nil) {
        controller?.view.endEditing(true)
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            completion?()
        }))
        
        controller?.present(self, animated: true, completion: nil)
    }
}
