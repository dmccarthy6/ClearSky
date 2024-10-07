//
//  HomeViewModel.swift
//  ClearSky
//
//  Created by Dylan  on 10/7/24.
//

import Foundation

struct HomeViewModel {
    // 1. If the user has granted us location auth, show weather screen and start search.
    // 2. If not, use last searched city (if we have it cached) otherwise make them search.

    // MARK: - Location

    func location(manager: LocationManager, database: LocalDatabase) async -> CityInfo? {
        switch manager.authStatus {
        case .notDetermined:
            manager.requestLocationAuthorizationFromUser()
            return nil
        case .restricted, .denied:
            return lastSearchedLocation(database)
        case .authorizedAlways, .authorizedWhenInUse:
            do {
                return try await getUsersCurrentLocation(locationManager: manager)
            } catch {
                // TODO: Error Handling
                // We errored out here, show the search controller.
                print("Error getting users current location. Error: - \(error)")
                return nil
            }
        @unknown default: return nil
        }
    }

    func getUsersCurrentLocation(locationManager: LocationManager) async throws -> CityInfo {
        try await withCheckedThrowingContinuation { continuation in
            locationManager.currentLocationForUser { location in
                guard let location else {
                    continuation.resume(throwing: <#T##any Error#>)
                    return
                }
                continuation.resume(returning: location)
            }
        }
    }

    // MARK: - Database

    /// <#Description#>
    func lastSearchedLocation(_ database: LocalDatabase) -> CityInfo? {
        database.getCityInfo()
    }
}
