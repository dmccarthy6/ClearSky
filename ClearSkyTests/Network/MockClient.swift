//
//  MockClient.swift
//  ClearSkyTests
//
//  Created by Dylan  on 10/4/24.
//

@testable import ClearSky
import Foundation
import SwiftUI

final class MockClient: Client {
    // Make this more robust
    enum TestHTTPError: Error {
        case failed
    }

    var data: Data?
    var error: Error?

    func get<T>(using request: any ClearSky.APIRequest) async throws -> T where T : Decodable, T : Encodable {
        if let error {
            throw error
        }
        guard let data else {
            throw TestHTTPError.failed
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    func getImage(using request: any ClearSky.APIRequest) async throws -> Image {
        if let error {
            throw error
        }
        guard let data else {
            throw TestHTTPError.failed
        }
        guard let uiImage = UIImage(data: data) else {
            throw TestHTTPError.failed
        }
        return Image(uiImage: uiImage)
    }
}

// Stubbed

extension CityInfo {
    var asData: Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }

    static var stubbed: CityInfo {
        CityInfo(name: "New York City",
                 localNames: nil,
                 lat: 40.7545006,
                 lon: 73.9921813,
                 country: "US",
                 state: "NY")
    }
}

extension WeatherInfo {
    var asData: Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }

    static var stubbed: WeatherInfo {
        WeatherInfo(coordinate: Coordinate(lon: 73.9921813, lat: 40.7545006),
                    weather: [Weather(id: 0, main: "Sunny", description: "Sunny", icon: "10N")],
                    base: "",
                    main: Main(temp: 75, feelsLike: 75, tempMin: 50, tempMax: 75, pressure: 20, humidity: 20, seaLevel: 20, grndLevel: 20),
                    visibility: 20,
                    wind: Wind(speed: 5, deg: 5),
                    clouds: Clouds(all: 10),
                    dt: 20,
                    sys: Sys(type: 20, id: 20, country: "United States", sunrise: 20, sunset: 20),
                    timezone: 20,
                    id: 20,
                    name: "New York City",
                    cod: 20)
    }
}
