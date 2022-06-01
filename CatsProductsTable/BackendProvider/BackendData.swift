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
    let productID: Int
}



enum Pets {
    case cats
    case dogs
    case rodents
}
