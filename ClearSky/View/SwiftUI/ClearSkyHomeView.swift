//
//  ClearSkyHomeView.swift
//  ClearSky
//
//  Created by Dylan  on 10/4/24.
//

import SwiftUI

struct ClearSkyHomeView: View {
    @Environment(\.locationManager) var locationManager
    @Environment(\.scenePhase) var scenePhase
    @StateObject var coordinator = AppCoordinator()
    @State private var isLoading = false
    let viewModel: HomeViewModel

    var body: some View {
        NavigationStack(path: $coordinator.routes) {
            VStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .controlSize(.large)
                }
            }
            .navigationTitle("Home")
            .navigationDestination(for: AppCoordinator.Routes.self) { route in
                coordinator.viewFor(route: route)
            }
        }
        .task {
            await configureViewAndNavigate()
        }
        .onChange(of: locationManager.authStatus) {
            Task { @MainActor in
                await configureViewAndNavigate()
            }
        }
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .inactive: return
            case .active:
                // Update our view when the user selects a location permission.
                Task {
                    await configureViewAndNavigate()
                }
            case .background: return
            @unknown default: return
            }
        }
    }

    private func configureViewAndNavigate() async {
        isLoading = true
        if locationManager.locationManager.authorizationStatus == .notDetermined {
            locationManager.requestLocationAuthorizationFromUser()
            return
        }

        let cityInfo = await viewModel.cityInfo(manager: locationManager,
                                                database: coordinator.database)
        isLoading = false
        coordinator.navigate(to: cityInfo == nil ? .search : .weatherInfo)
    }
}

#Preview {
    ClearSkyHomeView(viewModel: HomeViewModel())
}
