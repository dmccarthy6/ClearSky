//
//  SearchViewControllerRepresentable.swift
//  ClearSky
//
//  Created by Dylan  on 10/8/24.
//

import SwiftUI
import UIKit

struct SearchControllerRepresentable: UIViewControllerRepresentable {
    let coordinator: AppCoordinator
    let viewModel: SearchViewModel

    func makeCoordinator() -> SearchControllerCoordinator {
        SearchControllerCoordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> SearchViewController {
        let controller = SearchViewController()
        controller.textFieldDelegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: SearchViewController, context: Context) {
        // No-Op
    }

    // MARK: - Coordinator
    
    final class SearchControllerCoordinator: NSObject, UITextFieldDelegate {
        let parent: SearchControllerRepresentable

        init(parent: SearchControllerRepresentable) {
            self.parent = parent
        }

        // MARK: - UITextFieldDelegate

        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            switch reason {
            case .committed:
                getAndCacheCoordinateInfo(for: textField.text ?? "")
            case .cancelled:
                textField.resignFirstResponder()
            @unknown default: return
            }
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }

        private func getAndCacheCoordinateInfo(for cityName: String) {
            Task {
                do {
                    let viewModel = parent.viewModel
                    let database = parent.coordinator.database
                    try await viewModel.fetchAndCache(city: cityName, in: database)
                    DispatchQueue.main.async {
                        self.parent.coordinator.navigate(to: .weatherInfo)
                    }
                } catch {
#warning("TODO: IOS-005 - Error Handling")
                    print("FAILURE: \(error)")
                }
            }
        }
    }
}
