//
//  MockRequest.swift
//  ClearSkyTests
//
//  Created by Dylan  on 10/4/24.
//

@testable import ClearSky
import Foundation

enum MockRequest: APIRequest {
    case weather
    case coordinate(String)
    case image

    var host: String {
        "www.testendpoint.com"
    }

    var path: String {
        switch self {
        case .weather:
            return "weather"
        case .coordinate:
            return "coordinate"
        case .image:
            return "image"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .weather:
            return [
                URLQueryItem(name: "appid", value: "123456")
            ]
        case .coordinate(let cityName):
            return [
                URLQueryItem(name: "q", value: cityName),
                URLQueryItem(name: "appid", value: "123456")
            ]
        case .image: return []
        }
    }

    var request: URLRequest {
        URLRequest(url: url)
    }
}
