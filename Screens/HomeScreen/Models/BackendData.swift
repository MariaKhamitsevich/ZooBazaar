//
//  BackendData.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import Foundation
import UIKit
import FirebaseFirestore

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
    let productImageURL: UIImage!
    let productPrice: Double
    var isPopular: Bool
    let productID: Int
}



