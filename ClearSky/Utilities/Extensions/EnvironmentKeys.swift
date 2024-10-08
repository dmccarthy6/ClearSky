//
//  EnvironmentKeys.swift
//  ClearSky
//
//  Created by Dylan  on 10/7/24.
//

import SwiftUI

extension EnvironmentValues {
    var locationManager: LocationManager {
        get { self[LocationManagerKey.self] }
    }
}

private struct LocationManagerKey: EnvironmentKey {
    static let defaultValue: LocationManager = LocationManager()
}
