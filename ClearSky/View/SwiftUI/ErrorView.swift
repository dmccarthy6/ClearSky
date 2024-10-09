//
//  ErrorView.swift
//  ClearSky
//
//  Created by Dylan  on 10/8/24.
//

import SwiftUI

struct ErrorView: View {
    @Binding var error: HTTPError?

    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                Images.errorImage
                    .resizable()
                    .foregroundStyle(Color.red)
                    .frame(width: 75, height: 75)

                Text(error?.description ?? "")
                    .font(.body)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        error = nil
                    } label: {
                        Label {
                            Text("Dismiss")
                        } icon: {
                            Image("")
                        }
                    }
                }
            })
            .navigationTitle("Error")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ErrorView(error: .constant(.keyNotFound))
}
