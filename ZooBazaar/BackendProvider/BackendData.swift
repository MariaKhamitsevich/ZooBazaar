//
//  BackendData.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import Foundation
import UIKit

struct BackendData {
    let pet: Pets
    var backendData: [BackendProducts]
}

struct BackendProducts {
    let brendName: String
    var brendProducts: [BrandProducts]
}

struct BrandProducts {
    let productName: String
    let productDescription: String
    let productImage: UIImage!
    let productPrice: Double
    var weights: [Weights]
}

enum Weights: Int {
    case threehundred = 300
    case fivehundred = 500
    case onethousand = 1000
    case twothousand = 2000
}

enum Pets {
    case cats
    case dogs
    case rodents
}
