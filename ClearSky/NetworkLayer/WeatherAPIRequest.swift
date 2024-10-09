//
//  WeatherAPIRequest.swift
//  ClearSky
//
//  Created by Dylan  on 10/4/24.
//

import Foundation

/// Contains all the necessary information to interact with the openweathermap api.
enum WeatherAPIRequest: APIRequest {
    /// Get the weather for the specified latitude / longitude
    case getWeather(lat: Double, lon: Double)
    /// Get the city info for the specified city name.
    case getCoordinates(city: String)
    /// Get the icon for the specified iconId.
    case getIcon(String)

    var host: String {
        switch self {
        case .getWeather, .getCoordinates:
            "api.openweathermap.org"
        case .getIcon:
            "openweathermap.org"
        }

    }

    var path: String {
        switch self {
        case .getWeather:
            return "/data/2.5/weather"
        case .getCoordinates:
            return "/geo/1.0/direct"
        case .getIcon(let iconId):
            return "/img/wn/\(iconId)@2x.png"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .getWeather(let lat, let lon):
            return [
                URLQueryItem(name: "lat", value: String(lat)),
                URLQueryItem(name: "lon", value: String(lon)),
                URLQueryItem(name: "appid", value: apiKey),
                // Setting the units to imperial by default. This should be
                // dynamic.
                URLQueryItem(name: "units", value: "imperial")
            ]
        case .getCoordinates(let cityName):
            return [
                URLQueryItem(name: "q", value: cityName),
                URLQueryItem(name: "limit", value: "5"),
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "units", value: "imperial")
            ]
        case .getIcon: return []
        }
    }

    var request: URLRequest {
        URLRequest(url: url)
    }

    private var apiKey: String {
        // This is private information, should be stored
        // in the Keychain (secure enclave).
        "9f81eb1e1c95511b481af5a46a14f13f"
    }
}
