//
//  CityInfo.swift
//  ClearSky
//
//  Created by Dylan  on 10/4/24.
//

import Foundation

struct CityInfo: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }

    let id = UUID()
    let name: String
    let localNames: [String: String]?
    let lat: Double
    let lon: Double
    let country: String
    let state: String
}
