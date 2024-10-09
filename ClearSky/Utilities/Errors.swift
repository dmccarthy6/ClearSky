//
//  Errors.swift
//  ClearSky
//
//  Created by Dylan  on 10/8/24.
//

import Foundation

enum LocationError: Error, Identifiable {
    var id: Self {
        self
    }

    case currentLocationFailed
    case unhandled

    var description: String {
        return "Unable to retrieve your current location from the system. Try searching for your current city."
    }
}

enum HTTPError: Error, Identifiable {
    var id: Self {
        self
    }

    // Decoding Errors (Internal)
    case typeMismatch
    case valueNotFound
    case keyNotFound
    case dataCorrupted
    // This case is a catch-all for all other HTTP Errors
    // for simplicity sake. Would need to fix this.
    case unhandled

    var description: String {
        // For simplification just returning a single error string.
        return "Something went wrong retrieving the weather. Check your internet connection and try again."
    }
}
