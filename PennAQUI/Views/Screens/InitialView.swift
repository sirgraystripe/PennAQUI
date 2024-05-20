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
        HStack(alignment: .top, spacing: 20) {
            QualityRange(value: $store.activeFeed.airQualityIndex)
                .frame(maxWidth: 50)
                .padding(.vertical, Theme.constants.size25)
            Grid(alignment: .leading) {
                GridRow {
                    AQIRow()
                }
                .padding(.top, Theme.constants.size25)
                GridRow {
                    switch store.activeFeed.feedCategory {
                    case .city:
                        DetailCell(title: "CITY") {
                            Text(store.activeFeed.cityData?.name ?? "Unknown")
                        }
                    case .user:
                        HStack(alignment: .top) {
                            DetailCell(title: "CURRENT LAT / LONG") {
                                Text("\(store.activeFeed.cityData?.lat ?? 0.0)")
                                Text("\(store.activeFeed.cityData?.long ?? 0.0)")
                            }
                        }
                    }
                }
                GridRow {
                    DetailCell(title: "STATION") {
                        Text(store.activeFeed.stationInfo?.name ?? "")
                    }
                    .disabled(true)
                }
                Spacer()
                ActionMenu()
                    .padding(.bottom, Theme.constants.size50 * 2)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    InitialView()
        .environmentObject(Store.mocked)
}
