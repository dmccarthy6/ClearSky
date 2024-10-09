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
    @State private var error: ClearSkyError?
    let viewModel: HomeViewModel

    var body: some View {
        NavigationStack(path: $coordinator.routes) {
            VStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .controlSize(.large)
                }
                Text(viewModel.welcomeText)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 150)
                    .padding(.horizontal)
                VStack(spacing: 20) {
                    ClearSkyButton(title: "Weather Info") {
                        coordinator.navigate(to: .weatherInfo)
                    }
                    
                    ClearSkyButton(title: "Search") {
                        coordinator.navigate(to: .search)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Home")
            .navigationDestination(for: AppCoordinator.Routes.self) { route in
                coordinator.viewFor(route: route)
            }
        }
        .showError(item: $error, content: { error in
            ErrorView(error: $error)
        })
        .task {
            await configureViewAndNavigate()
        }
        .onChange(of: locationManager.locationError, {
            self.error = locationManager.locationError
        })
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

        do {
            let cityInfo = try await viewModel.cityInfo(manager: locationManager,
                                                    database: coordinator.database)
            isLoading = false
            coordinator.navigate(to: cityInfo == nil ? .search : .weatherInfo)
        } catch let error as ClearSkyError {
            self.error = error
        } catch {
            self.error = .httpUnhandled
        }
    }
}

#Preview {
    ClearSkyHomeView(viewModel: HomeViewModel())
}
