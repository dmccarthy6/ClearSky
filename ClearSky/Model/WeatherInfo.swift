//
//  WeatherInfo.swift
//  ClearSky
//
//  Created by Dylan  on 10/4/24.
//

import Foundation

struct WeatherInfo: Codable, Identifiable {
    let coordinate: Coordinate
    /// Main weather info including description and icon.
    let weather: [Weather]
    ///
    let base: String
    ///
    let main: Main
    ///
    let visibility: Int
    ///
    let wind: Wind
    ///
    let clouds: Clouds
    ///
    let dt: Int
    ///
    let sys: Sys
    ///
    let timezone, id: Int
    ///
    let name: String
    ///
    let cod: Int
}

struct Coordinate: Codable {
    /// longitude
    let lon: Double
    /// latitude
    let lat: Double
}

struct Weather: Codable {
    /// Weather condition id
    let id: Int
    /// Group of weather parameters (Rain, Snow Clouds, etc.)
    let main: String
    /// Weather condition within the group
    let description: String
    /// Weather icon id
    let icon: String
}

struct Main: Codable {
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }

    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    let seaLevel: Int
    let grndLevel: Int
}

struct Wind: Codable {
    /// Wind speed
    let speed: Int
    /// Wind direction
    let deg: Int
}

struct Clouds: Codable {
    /// Cloudiness %
    let all: Int
}

struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
