//
//  AppCoordinator.swift
//  ClearSky
//
//  Created by Dylan  on 10/7/24.
//

import Foundation
import SwiftUI

final class AppCoordinator: ObservableObject {
    enum Routes: Hashable {
        case search
        case weatherInfo
    }

    let database = LocalDatabase()
    let networkService = NetworkService()
    @Published var routes: [Routes] = []

    func navigate(to route: Routes) {
        routes.append(route)
    }

    func navigateBack() {
        routes.removeLast()
    }

    func weatherInfoView() -> WeatherInfoView {
        let viewModel = WeatherInfoViewModel(service: networkService)
        return WeatherInfoView(viewModel: viewModel)
    }

    func searchView() {
        
    }
}
