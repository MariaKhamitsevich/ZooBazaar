//
//  UIFont.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 16.05.22.
//

import UIKit

extension UIFont {

    func withTraits(traits:UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits)) else { return .boldSystemFont(ofSize: 12) }
        return UIFont(descriptor: descriptor, size: 0)
    }

    func boldItalic() -> UIFont {
        return withTraits(traits: .traitBold, .traitItalic)
    }

   
}
