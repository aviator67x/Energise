//
//  ResponseModel.swift
//  Energise
//
//  Created by Andrew Kasilov on 29.04.2024.
//

import Foundation

struct ResponseModel: Decodable {
    let country: String
    let countryCode: String
    let region: String
    let regionName: String
    let city: String
    let zip: String
    let lat: Double
    let lon: Double
    let timezone: String
    let org: String

    init(data: ResponseModel) {
        self.country = data.country
        self.countryCode = data.countryCode
        self.region = data.region
        self.regionName = data.regionName
        self.city = data.city
        self.zip = data.zip
        self.lat = data.lat
        self.lon = data.lon
        self.timezone = data.timezone
        self.org = data.org
    }
}
