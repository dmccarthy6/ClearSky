//
//  LocalDatabase.swift
//  ClearSky
//
//  Created by Dylan  on 10/4/24.
//

import Foundation

protocol Persistence {
    func store<T: Codable>(value: T, forKey: UserDefaults.Key)
    func getCityInfo(for key: UserDefaults.Key) -> CityInfo?
}

struct LocalDatabase: Persistence {
    let defaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
    }
    
    /// Store Codable model in UserDefaults to display the last location the user searched.
    /// - Parameters:
    ///   - value: Codable object to store.
    ///   - forKey: Key value
    func store<T: Codable>(value: T, forKey: UserDefaults.Key) {
        guard let data = try? JSONEncoder().encode(value) else {
            return
        }
        defaults.save(value: NSData(data: data), forKey: forKey)
    }
    
    /// Retrieve the last visited location for the user.
    /// - Parameter key: UserDefaults key
    /// - Returns: `CityInfo` if one exists in UserDefaults.
    func getCityInfo(for key: UserDefaults.Key = .lastLocation) -> CityInfo? {
        guard let data = defaults.readData(for: key) else {
            return nil
        }
        return try? JSONDecoder().decode(CityInfo.self, from: data)
    }
}

// MARK: - UserDefaults Extension

extension UserDefaults {
    enum Key: String {
        case lastLocation = "lastVisitedLocation"
        case two
    }

    func save(value: Any?, forKey: Key) {
        setValue(value, forKey: forKey.rawValue)
    }

    func readData(for key: Key) -> Data? {
        value(forKey: key.rawValue) as? Data
    }
}
