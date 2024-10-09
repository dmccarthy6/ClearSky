//
//  Errors.swift
//  ClearSky
//
//  Created by Dylan  on 10/8/24.
//

import Foundation

enum ClearSkyError: Error, Identifiable {
    var id: Self {
        self
    }

    // MARK: - Location Errors
    case currentLocationFailed
    case locationUnhandled

    // MARK: - HTTP Errors

    // Decoding Errors (Internal)
    case typeMismatch
    case valueNotFound
    case keyNotFound
    case dataCorrupted
    // This case is a catch-all for all other HTTP Errors
    // for simplicity sake. Would need to fix this.
    case httpUnhandled

    var description: String {
        switch self {
        case .currentLocationFailed, .locationUnhandled:
            return "Unable to retrieve your current location from the system. Try searching for your current city."
        case .typeMismatch, .valueNotFound, .keyNotFound,
                .dataCorrupted, .httpUnhandled:
            return "Something went wrong retrieving the weather. Check your internet connection and try again."
        }
    }
}
