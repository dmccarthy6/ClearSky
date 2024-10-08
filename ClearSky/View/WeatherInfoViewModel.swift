//
//  WeatherInfoViewModel.swift
//  ClearSky
//
//  Created by Dylan  on 10/7/24.
//

import Foundation
import SwiftUI

struct WeatherInfoViewModel {
    let service: NetworkService

    func getWeatherInfo(latitude: Double, longitude: Double) async throws -> WeatherInfo {
        try await service.getWeather(for: latitude, lon: longitude)
    }

    func getIcon(weatherInfo: WeatherInfo) async throws -> Image {
        do {
            let weather = weatherInfo.weather.first
            return try await service.getIcon(with: weather?.icon ?? "")
        } catch {
            return Images.placeholderImage
        }
    }
}
