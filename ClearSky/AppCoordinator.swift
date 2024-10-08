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
        guard !routes.contains(route) else {
            return
        }
        routes.append(route)
    }

    func navigateBack() {
        routes.removeLast()
    }

    @ViewBuilder
    func viewFor(route: AppCoordinator.Routes) -> some View {
        let navigationTitle = navigationTitle(for: route)
        switch route {
        case .search:
            searchView()
                .navigationTitle(navigationTitle)
        case .weatherInfo:
            if let cachedCity = database.getCityInfo() {
                weatherInfoView(for: cachedCity)
                    .navigationTitle(navigationTitle)
            } else {
                searchView()
            }
        }
    }

    private func weatherInfoView(for city: CityInfo) -> WeatherInfoView {
        let viewModel = WeatherInfoViewModel(service: networkService, cityInfo: city)
        return WeatherInfoView(viewModel: viewModel)
    }

    private func searchView() -> SearchControllerRepresentable {
        let viewModel = SearchViewModel(service: networkService)
        return SearchControllerRepresentable(coordinator: self, viewModel: viewModel)
    }
    
    private func navigationTitle(for route: Routes) -> String {
        switch route {
        case .search: return "Search"
        case .weatherInfo: return "Weather"
        }
    }
}
