//
//  AppCoordinator.swift
//  ClearSky
//
//  Created by Dylan  on 10/7/24.
//

import Foundation
import SwiftUI

final class AppCoordinator: ObservableObject {
    enum Routes {
        case search
        case weatherInfo
    }

    @Published var routes: [Routes] = []

    func navigate(to route: Routes) {
        routes.append(route)
    }

    func navigateBack() {
        routes.removeLast()
    }

    func view(for route: Routes) -> some View {
        switch route {
        case .search:
            Text("IOS-004 - Search Screen")
        case .weatherInfo:
            Text("IOS-006 - Weather Info View")
        }
    }
}
