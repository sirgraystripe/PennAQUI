//
//  InitialView.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Charts
import SwiftUI

struct InitialView: View {
    @EnvironmentObject private var store: Store

    var body: some View {
        HStack(spacing: 20) {
            QualityRange(value: $store.feedData.airQualityIndex)
                .frame(maxWidth: 50)
            Grid(alignment: .leading) {
                GridRow {
                    DetailCell(title: "AQI") {
                        // capHeight is not 100%, but good for reducing baseline
                        Text("\(store.feedData.airQualityIndex ?? 0)")
                            .font(Theme.fonts.gigantic)
                            .frame(height: Theme.fonts.giganticUIFont.capHeight)
                    }
                }
                .padding(.top, Theme.constants.size50)
                GridRow {
                    HStack(alignment: .top) {
                        DetailCell(title: "LAT / LONG") {
                            Text("\(store.feedData.cityData?.lat ?? 0.0)")
                            Text("\(store.feedData.cityData?.long ?? 0.0)")
                        }
                    }
                }
                GridRow {
                    DetailCell(title: "CITY") {
                        Text(store.feedData.cityData?.name ?? "Unknown")
                    }
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal, 30)
        .onAppear {
            Task {
                await store.load(city: .name("hi"))
            }
        }
    }
}

#Preview {
    InitialView()
        .environmentObject(Store.mocked)
}
