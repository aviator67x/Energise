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
}
