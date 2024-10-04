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
