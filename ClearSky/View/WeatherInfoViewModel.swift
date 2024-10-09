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
}
