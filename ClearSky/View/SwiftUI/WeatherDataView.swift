//
//  WeatherDataView.swift
//  ClearSky
//
//  Created by Dylan  on 10/7/24.
//

import SwiftUI

struct WeatherDataView: View {
    let weatherInfo: WeatherInfo?
    let icon: Image

    var body: some View {
        VStack(spacing: 20) {
            Text(weatherInfo?.name ?? "Unknown")
                .font(.largeTitle)
            icon
                .resizable()
                .frame(width: 100, height: 100)

            HStack {
                Text("L: \(String(weatherInfo?.main.tempMin ?? 0))")
                Text("H: \(String(weatherInfo?.main.tempMin ?? 0))")
            }
            Text(weatherInfo?.weather.first?.description ?? "")
        }
    }
}

#Preview {
    WeatherDataView(weatherInfo: nil, icon: Images.placeholderImage)
}
