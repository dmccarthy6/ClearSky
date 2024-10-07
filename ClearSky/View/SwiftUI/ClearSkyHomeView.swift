//
//  ClearSkyHomeView.swift
//  ClearSky
//
//  Created by Dylan  on 10/4/24.
//

import SwiftUI

struct ClearSkyHomeView: View {
    @Environment(\.locationManager) var locationManager
    @StateObject var coordinator: AppCoordinator
    @State private var city: CityInfo?
    private let viewModel: HomeViewModel

    var body: some View {
        NavigationStack(path: $coordinator.routes) {
            Text("A View")
                .navigationDestination(for: AppCoordinator.Routes.self) { route in
                    switch route {
                    case .requestLocationAuth: Text("RequestAuth")
                    case .search: Text("Search")
                    case .weatherInfo: Text("Weather Info")
                    }
                }
        }
        .task {
            city = await viewModel.location(manager: locationManager,
                                               database: coordinator.database)
            coordinator.navigate(to: city == nil ? .search : .weatherInfo)
        }
    }

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    ClearSkyHomeView(viewModel: HomeViewModel())
}
