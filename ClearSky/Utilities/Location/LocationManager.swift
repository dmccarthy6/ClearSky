//
//  LocationManager.swift
//  ClearSky
//
//  Created by Dylan  on 10/4/24.
//

import CoreLocation

final class LocationManager: NSObject, ObservableObject {
    let locationManager: CLLocationManager
    private var locationClosure: LocationClosure?
    var authorizationGranted: Bool {
        locationManager.authorizationStatus == .authorizedWhenInUse ||
        locationManager.authorizationStatus == .authorizedAlways
    }

    @Published var authStatus: CLAuthorizationStatus?

    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
    }

    /// This function calls `CLLocationManager's` `requestWhenInUseAuthorization`
    /// when the current auth status is `.notDetermined`. If the user has already set a location
    /// auth for this app besides notDetermined nothing will happen.
    func requestLocationAuthorizationFromUser() {
        guard authStatus == .notDetermined else {
            return
        }
        locationManager.requestWhenInUseAuthorization()
    }
    
    /// Retrieve the CLLocation for the current user. This will only work if
    /// the authStatus is either `authorizedWhenInUse` or `authorizedAlways`.
    func currentLocationForUser(_ completion: @escaping LocationClosure) {
        locationClosure = completion

        guard locationManager.authorizationStatus == .authorizedWhenInUse ||
                locationManager.authorizationStatus == .authorizedAlways else {
            completion(nil)
            return
        }

        locationManager.requestLocation()
    }
}

// MARK: - CLLocationManager Delegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard self.authStatus != manager.authorizationStatus else { return }
        authStatus = manager.authorizationStatus
    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            locationClosure?(nil)
            locationClosure = nil
            return
        }
        let cityInfo = CityInfo(name: "Unknown",
                                localNames: nil,
                                lat: location.coordinate.latitude,
                                lon: location.coordinate.longitude,
                                country: "Unknown",
                                state: "Unknown")
        locationClosure?(cityInfo)
        locationClosure = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
#warning("TODO: IOS-005 - Error Handling")
        print("Timeout searching for users current location: \(error)")
    }
}
