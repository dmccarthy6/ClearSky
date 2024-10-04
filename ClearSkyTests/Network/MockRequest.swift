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
    case coordinate
    case image

    var host: String {
        "www.google.com"
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
        case .coordinate:
            return [
                URLQueryItem(name: "appid", value: "123456")
            ]
        case .image: return []
        }
    }

    var request: URLRequest {
        URLRequest(url: url)
    }
}
