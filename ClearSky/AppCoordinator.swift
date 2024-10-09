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

    private func weatherInfoView(for city: CityInfo) -> some View {
        let viewModel = WeatherInfoViewModel(service: networkService, cityInfo: city)
        let weatherInfoView = WeatherInfoView(viewModel: viewModel)
            .navigationBar(title: navigationTitle(for: .weatherInfo)) { [weak self] in
                self?.showSearch()
            }
        return weatherInfoView
    }

    private func searchView() -> some View {
        let viewModel = SearchViewModel(service: networkService)
        let searchView = SearchControllerRepresentable(coordinator: self, viewModel: viewModel)
            .navigationTitle(navigationTitle(for: .search))
        return searchView
    }
    
    private func navigationTitle(for route: Routes) -> String {
        switch route {
        case .search: return "Search"
        case .weatherInfo: return "Weather"
        }
    }

    private func showSearch() {
        if routes.contains(.search) {
            print("Search in there, popping back")
            navigateBack()
        } else {
            print("No search, navigating to it")
            // Pop the WeatherInfo view off the stack in order to
            // "navigate back" to the WeatherInfo screen with the new data.
            // Hack here to make the UX work.
            navigateBack()
            routes.append(.search)
        }
    }
}
