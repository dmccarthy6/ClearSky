//
//  WeatherInfoView.swift
//  ClearSky
//
//  Created by Dylan  on 10/8/24.
//

import SwiftUI

struct WeatherInfoView: View {
    @State private var isLoading = false
    @State private var error: ClearSkyError?
    @State private var weatherInfo: WeatherInfo?
    @State private var icon: Image = Image("")
    let viewModel: WeatherInfoViewModel

    var body: some View {
        VStack {
            WeatherDataView(cityName: weatherInfo?.name ?? "",
                            icon: icon,
                            dailyLow: String(weatherInfo?.main.tempMin ?? 0),
                            dailyHigh: String(weatherInfo?.main.tempMax ?? 0))

            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            Spacer()
        }
        .refreshable {
            // TODO: Debounce so users can't fetch multiple times.
            await loadWeatherData()
        }
        .showError(item: $error, content: { error in
            ErrorView(error: $error)
        })
        .task {
            await loadWeatherData()
        }
    }

    private func loadWeatherData() async {
        do {
            isLoading = true
            let info = try await viewModel.getWeatherInfo()
            weatherInfo = info
            icon = try await viewModel.getIcon(weatherInfo: info)
            isLoading = false
        } catch let error as ClearSkyError {
            isLoading = false
            self.error = error
        } catch {
            self.error = .httpUnhandled
        }
    }
}

#Preview {
    WeatherInfoView(viewModel: WeatherInfoViewModel(service: NetworkService(), cityInfo: CityInfo(name: "", localNames: nil, lat: 0, lon: 0, country: "", state: "")))
}

