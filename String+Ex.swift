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
