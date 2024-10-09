//
//  HomeViewModel.swift
//  ClearSky
//
//  Created by Dylan  on 10/7/24.
//

import Foundation

struct HomeViewModel {

    // MARK: - Location

    func cityInfo(manager: LocationManager,
                database: LocalDatabase) async throws -> CityInfo? {
        do {
            if manager.authorizationGranted {
                let cityInfo = try await getUsersCurrentLocation(locationManager: manager)
                database.store(value: cityInfo, forKey: .lastLocation)
                return cityInfo
            } else {
                return lastSearchedLocation(database)
            }
        } catch let error as ClearSkyError {
            throw error
        } catch {
            throw ClearSkyError.httpUnhandled
        }
    }

    /// User has granted location authorizations. Retrieve the current location for the user
    /// - Parameter locationManager: `LocationManager`
    /// - Returns: `CityInfo` upon success.
    private func getUsersCurrentLocation(locationManager: LocationManager) async throws -> CityInfo {
        try await withCheckedThrowingContinuation { continuation in
            locationManager.currentLocationForUser { location in
                guard let location else {
                    continuation.resume(throwing: ClearSkyError.currentLocationFailed)
                    return
                }
                continuation.resume(returning: location)
            }
        }
    }

    // MARK: - Database

    /// Check for a last searched location in the database (UserDefaults).
    private func lastSearchedLocation(_ database: LocalDatabase) -> CityInfo? {
        database.getCityInfo()
    }
}
