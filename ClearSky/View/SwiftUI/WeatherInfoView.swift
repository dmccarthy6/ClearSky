//
//  WeatherInfoView.swift
//  ClearSky
//
//  Created by Dylan  on 10/8/24.
//

import SwiftUI

struct WeatherInfoView: View {
    @State private var isLoading = false
    @State private var weatherInfo: WeatherInfo?
    @State private var icon: Image?
    let viewModel: WeatherInfoViewModel

    var body: some View {
        ZStack {
            WeatherDataView(cityName: weatherInfo?.name ?? "",
                            icon: icon ?? Images.placeholderImage,
                            dailyLow: String(weatherInfo?.main.tempMin ?? 0),
                            dailyHigh: String(weatherInfo?.main.tempMax ?? 0))

            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .task {
            do {
                isLoading = true
                let info = try await viewModel.getWeatherInfo(latitude: weatherInfo?.coordinate.lat ?? 0,
                                                              longitude: weatherInfo?.coordinate.lon ?? 0)
                weatherInfo = info
                let weatherIcon = try await viewModel.getIcon(weatherInfo: info)
                icon = weatherIcon
                isLoading = false
            } catch {
                isLoading = false
                // TODO: Error Handling
            }
        }
    }
}

#Preview {
    WeatherInfoView(viewModel: WeatherInfoViewModel(service: NetworkService()))
}
