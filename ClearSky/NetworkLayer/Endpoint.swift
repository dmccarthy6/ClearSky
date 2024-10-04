//
//  Endpoint.swift
//  ClearSky
//
//  Created by Dylan  on 10/4/24.
//

import Foundation

/// Defines the requirements for creating an endpoint.
protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var url: URL { get }
}

/// Defines the requirements for performing an API request.
protocol APIRequest: Endpoint {
    var request: URLRequest { get }
}

// MARK: - Endpoint Extension

extension Endpoint {
    var scheme: String {
        "https"
    }

    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        guard let url = components.url else {
            fatalError("")
        }
        return url
    }
}
