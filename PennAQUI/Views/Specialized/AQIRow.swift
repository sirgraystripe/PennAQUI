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
        VStack(alignment: .leading) {
            DetailCell(title: "AQI") {
                // capHeight is not 100%, but good for reducing baseline
                Text("\(store.activeFeed.airQualityIndex ?? 0)")
                    .font(Theme.fonts.gigantic)
                    .frame(height: Theme.fonts.giganticUIFont.capHeight)
            }
            HStack {
                DetailCell(
                    title: "Tomorrow",
                    systemImage: "arrow.left.circle.fill"
                ) {
                    Text("\(store.activeFeed.forecast?.yesterdayPM25 ?? 0)")
                        .font(Theme.fonts.body)
                }
                DetailCell(
                    title: "Day After",
                    systemImage: "arrow.right.circle.fill"
                ) {
                    Text("\(store.activeFeed.forecast?.tomorrowPM25 ?? 0)")
                        .font(Theme.fonts.body)
                }
            }
        }
    }
}

#Preview {
    @State var store = Store.mocked
    return InitialView()
        .environmentObject(store)
        .onAppear {
            Task {
                await store.loadUserFeed(userCoordinates: .init(latitude: 10, longitude: 10))
            }
        }
}
