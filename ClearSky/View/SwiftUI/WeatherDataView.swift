//
//  WeatherDataView.swift
//  ClearSky
//
//  Created by Dylan  on 10/7/24.
//

import SwiftUI

struct WeatherDataView: View {
    private let imageWidth: Double = 100
    private let imageHeight: Double = 100
    private var url: URL {
        let iconId = weatherInfo?.weather.first?.icon ?? ""
        print(iconId)
        return WeatherAPIRequest.getIcon(iconId).url
    }

    let weatherInfo: WeatherInfo?

    var body: some View {
        VStack(spacing: 20) {
            Text(weatherInfo?.name ?? "Unknown")
                .font(.largeTitle)

            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .controlSize(.large)
                case .success(let image):
                    sized(image: image)
                case .failure:
                    sized(image: Images.placeholderImage)
                @unknown default:
                    Images.placeholderImage
                }
            }

            HStack {
                Text("L: \(String(weatherInfo?.main.tempMin ?? 0))")
                Text("H: \(String(weatherInfo?.main.tempMin ?? 0))")
            }
            Text((weatherInfo?.weather.first?.description ?? "").capitalized)
        }
    }

    private func sized(image: Image) -> some View {
        image
            .resizable()
            .frame(width: imageWidth, height: imageHeight)
    }
}

#Preview {
    WeatherDataView(weatherInfo: nil)
}
