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

    func weatherInfoView(for city: CityInfo) -> WeatherInfoView {
        let viewModel = WeatherInfoViewModel(service: networkService, cityInfo: city)
        return WeatherInfoView(viewModel: viewModel)
    }

    func searchView() -> SearchControllerRepresentable {
        let viewModel = SearchViewModel(service: networkService)
        return SearchControllerRepresentable(coordinator: self, viewModel: viewModel)
    }

    func navigationTitle(for route: Routes) -> String {
        switch route {
        case .search: return "Search"
        case .weatherInfo: return "Weather"
        }
    }
}
