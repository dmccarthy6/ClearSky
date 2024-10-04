//
//  LocationManager.swift
//  ClearSky
//
//  Created by Dylan  on 10/4/24.
//

import CoreLocation

final class LocationManager: NSObject, Observable {
    private(set) lazy var manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()

    @Published var authStatus: CLAuthorizationStatus = .notDetermined
    
    /// This function calls `CLLocationManager's` `requestWhenInUseAuthorization`
    /// when the current auth status is `.notDetermined`. If the user has already set a location
    /// auth for this app besides notDetermined nothing will happen.
    func requestLocationAuthorizationFromUser() {
        guard authStatus == .notDetermined else {
            return
        }
        manager.requestWhenInUseAuthorization()
    }
    
    /// Retrieve the CLLocation for the current user. This will only work if
    /// the authStatus is either `authorizedWhenInUse` or `authorizedAlways`.
    func getUserCurrentLocation() {
        guard authStatus == .authorizedWhenInUse ||
                authStatus == .authorizedAlways else {
            return
        }
        manager.startUpdatingLocation()
    }
}

// MARK: - CLLocationManager Delegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authStatus = manager.authorizationStatus
    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        let location = locations.last ?? CLLocation()
        #warning("TODO: Cache location data so we can show this when the user logs in.")
        manager.stopUpdatingLocation()
    }
}
