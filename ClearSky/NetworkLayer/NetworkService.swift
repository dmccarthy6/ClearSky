//
//  NetworkService.swift
//  ClearSky
//
//  Created by Dylan  on 10/4/24.
//

import Foundation
import SwiftUI

struct NetworkService {
    private let client: Client

    init(client: Client = HTTPClient()) {
        self.client = client
    }
    
    /// Get the geo cordinates for the specified city name.
    /// - Parameter city: Name of the city.
    /// - Returns: `CityInfo` which includes the lat and lon.
    func getCityCoordinates(for city: String) async throws -> [CityInfo] {
        let request = WeatherAPIRequest.getCoordinates(city: city)
        return try await client.get(using: request, object: [CityInfo].self)
    }
    
    /// Get weather info for the provided lat and lon.
    /// - Parameters:
    ///   - lat: Latitude coordinate for the city.
    ///   - lon: Longitude coordinate for the city.
    /// - Returns: `WeatherInfo` object that includes data about the weather.
    func getWeather(for lat: Double, lon: Double) async throws -> WeatherInfo {
        let request = WeatherAPIRequest.getWeather(lat: lat, lon: lon)
        return try await client.get(using: request, object: WeatherInfo.self)
    }
    
    /// Get the icon for the specified icon id.
    /// - Parameter id: The id of the weather icon.
    /// - Returns: `Image`
    /// - Note: The icon id can be retrieved from a `WeatherInfo` object by
    /// accessing `Weather.id`.
    func getIcon(with id: String) async throws -> Image {
        let request = WeatherAPIRequest.getIcon(id)
        return try await client.getImage(using: request)
    }
}
