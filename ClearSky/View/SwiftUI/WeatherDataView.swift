//
//  WeatherDataView.swift
//  ClearSky
//
//  Created by Dylan  on 10/7/24.
//

import SwiftUI

struct WeatherDataView: View {
    let cityName: String
    let icon: Image
    let dailyLow: String
    let dailyHigh: String

    var body: some View {
        VStack(spacing: 20) {
            Text(cityName)
                .font(.largeTitle)
            icon
                .resizable()
                .frame(width: 100, height: 100)

            HStack {
                Text("L: \(dailyLow)")
                Text("H: \(dailyHigh)")
            }
        }
    }
}

#Preview {
    WeatherDataView(cityName: "New York",
                    icon: Images.placeholderImage,
                    dailyLow: "50",
                    dailyHigh: "75")
}
