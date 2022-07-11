//
//  RegexType.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 29.06.22.
//

import Foundation

enum RegexType: String {
    case password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case phone = "^(\\+375|80)(29|25|44|33)(\\d{3})(\\d{2})(\\d{2})$"
}
