//
//  HTTPClient.swift
//  ClearSky
//
//  Created by Dylan  on 10/4/24.
//

import Foundation
import SwiftUI

/// Methods for interacting with URLSession in production and for mocking in tests.
protocol Client {
    func get<T: Codable>(using request: APIRequest) async throws -> T
    func getImage(using request: APIRequest) async throws -> Image
}

class HTTPClient: Client {
    let session: URLSession

    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }

    func get<T>(using request: any APIRequest) async throws -> T where T : Decodable, T : Encodable {
        let (data, _) = try await session.data(for: request.request)
        return try JSONDecoder().decode(T.self, from: data)
    }

    func getImage(using request: any APIRequest) async throws -> Image {
        let (data, _) = try await session.data(for: request.request)
        guard let uiImage = UIImage(data: data) else {
#warning("TODO: IOS-003 - Implement caching (return a default image here)")
            fatalError()
        }
        return Image(uiImage: uiImage)
    }
}
