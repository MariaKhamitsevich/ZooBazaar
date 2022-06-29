//
//  String+Ex.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 19.06.22.
//

import Foundation

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}





//        attributedSring.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
//        attributedSring.addAttribute(.font, value: font, range: range)
//        attributedSring.addAttributes([.underlineStyle : NSUnderlineStyle.single.rawValue, .font : font], range: range)
//        button.titleLabel?.attributedText = attributedSring
