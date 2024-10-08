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
    let cityInfo: CityInfo

    func getWeatherInfo() async throws -> WeatherInfo {
        try await service.getWeather(for: cityInfo.lat, lon: cityInfo.lon)
    }

    func getIcon(weatherInfo: WeatherInfo) async throws -> Image {
        do {
            let weather = weatherInfo.weather.first
            return try await service.getIcon(with: weather?.icon ?? "")
        } catch {
#warning("TODO: IOS-005 - Error Handling")
            print("Error getting icon. Error - \(error)")
            throw error
        }
    }
}
