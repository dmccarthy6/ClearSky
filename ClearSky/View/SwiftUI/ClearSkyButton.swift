//
//  ClearSkyButton.swift
//  ClearSky
//
//  Created by Dylan  on 10/9/24.
//

import SwiftUI
import UIKit

struct ClearSkyButton: View {
    let title: String
    let action: VoidClosure
    private let color: UIColor = .secondarySystemBackground

    var body: some View {
        HStack {
            Button {
                action()
            } label: {
                Text(title)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(ClearSkyButtonStyle(background: color))
        }
    }
}

#Preview {
    ClearSkyButton(title: "Button Title", action: {})
}

struct ClearSkyButtonStyle: ButtonStyle {
    let background: UIColor

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(uiColor: background))
            .foregroundStyle(Color(uiColor: .label))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
