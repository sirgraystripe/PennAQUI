//
//  AQIRow.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/20/24.
//

import SwiftUI

struct AQIRow: View {
    @EnvironmentObject private var store: Store

    var body: some View {
        HStack(alignment: .top) {
            DetailCell(title: "AQI") {
                // capHeight is not 100%, but good for reducing baseline
                Text("\(store.activeFeed.airQualityIndex ?? 0)")
                    .font(Theme.fonts.gigantic)
                    .frame(height: Theme.fonts.giganticUIFont.capHeight)
            }

            HStack {
                DetailCell(
                    title: "Yesterday",
                    systemImage: "arrow.left.circle.fill"
                ) {
                    Text("\(store.activeFeed.airQualityIndex ?? 0)")
                        .font(Theme.fonts.body)
                }
                DetailCell(
                    title: "Tomorrow",
                    systemImage: "arrow.right.circle.fill"
                ) {
                    Text("\(store.activeFeed.airQualityIndex ?? 0)")
                        .font(Theme.fonts.body)
                }
            }
        }
    }
}

#Preview {
    AQIRow()
}
