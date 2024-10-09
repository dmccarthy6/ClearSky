//
//  View+Additions.swift
//  ClearSky
//
//  Created by Dylan  on 10/9/24.
//

import SwiftUI

extension View {
    func showError<Content: View>(item: Binding<ClearSkyError?>,
                                  @ViewBuilder content: @escaping ((ClearSkyError) -> Content)) -> some View {
        self
            .sheet(item: item, content: content)
    }

    func navigationBar(title: String,
                       displayMode: ToolbarTitleDisplayMode = .inline, action: @escaping VoidClosure) -> some View {
        self
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        action()
                    } label: {
                        Images.magnifyingGlass
                    }

                }
            }
            .navigationTitle(Text(title))
            .toolbarTitleDisplayMode(displayMode)
    }
}
