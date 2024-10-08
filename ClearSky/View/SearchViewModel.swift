//
//  SearchViewModel.swift
//  ClearSky
//
//  Created by Dylan  on 10/8/24.
//

import Foundation

final class SearchViewModel {
    let service: NetworkService

    init(service: NetworkService) {
        self.service = service
    }

    func getCityInfo(for cityName: String) async throws -> [CityInfo] {
        try await service.getCityCoordinates(for: cityName)
    }

    func fetchAndCache(city: String, in database: LocalDatabase) async throws {
        let cities = try await service.getCityCoordinates(for: city)
        database.store(value: cities.first, forKey: .lastLocation)
    }
}
