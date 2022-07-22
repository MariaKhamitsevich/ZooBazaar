//
//  MarketsModel.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 18.07.22.
//

import Foundation


class ZBZMarket {
    var latitude: Double?
    var longitude: Double?
    var workingHours: String?
    var name: String?
    var description: String?
    var address: String?

    init(latitude: Double, longitude: Double, name: String, workingHours: String, description: String) {
        self.workingHours = workingHours
        self.name = name
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
    }
}
