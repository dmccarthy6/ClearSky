//
//  TestNetworkService.swift
//  ClearSkyTests
//
//  Created by Dylan  on 10/4/24.
//

@testable import ClearSky
import Testing

struct TestNetworkService {
    let client = MockClient()

    @Test func testGettingCoordinateForCity() async throws {
        client.data = CityInfo.stubbed.asData
        let service = NetworkService(client: client)
        let city = "New York City"

        let cityInfo = try await service.getCityCoordinates(for: city)

        #expect(cityInfo.name == city, "Decoding CityInfo name failed")
    }

    @Test func testGettingWeatherForCoordinate() async throws {
        client.data = WeatherInfo.stubbed.asData
        let service = NetworkService(client: client)
        let lat: Double = 40.7545006
        let lon: Double = 73.9921813

        let weatherInfo = try await service.getWeather(for: lat, lon: lon)

        #expect(weatherInfo.coordinate.lat == lat, "Decoding WeatherInfo latitude values dont match")
        #expect(weatherInfo.coordinate.lon == lon, "Decoding WeatherInfo longitude values dont match")
    }
}
