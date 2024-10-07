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
    private var locationClosure: LocationClosure?

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
    func currentLocationForUser(_ completion: @escaping LocationClosure) {
        locationClosure = completion

        guard authStatus == .authorizedWhenInUse ||
                authStatus == .authorizedAlways else {
            completion(nil)
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
        manager.stopUpdatingLocation()

        let location = locations.last
        guard let location = location else {
            locationClosure?(nil)
            return
        }
        let cityInfo = CityInfo(name: "Unknown",
                                localNames: nil,
                                lat: location.coordinate.latitude,
                                lon: location.coordinate.longitude,
                                country: "Unknown",
                                state: "Unknown")
        locationClosure?(cityInfo)
    }
}
