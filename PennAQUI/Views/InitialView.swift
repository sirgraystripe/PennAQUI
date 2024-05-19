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
            QualityRange(value: $store.activeFeed.airQualityIndex)
                .frame(maxWidth: 50)
            Grid(alignment: .leading) {
                GridRow {
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
                .padding(.top, Theme.constants.size50)
                GridRow {
                    if store.activeFeed.isDerivedFromCurrentLocation {
                        HStack(alignment: .top) {
                            DetailCell(title: "CURRENT LAT / LONG") {
                                Text("\(store.activeFeed.cityData?.lat ?? 0.0)")
                                Text("\(store.activeFeed.cityData?.long ?? 0.0)")
                            }
                        }
                    } else {
                        DetailCell(title: "CITY") {
                            Text(store.activeFeed.cityData?.name ?? "Unknown")
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
        .padding(.horizontal, 30)
        .onAppear {
            Task {
                await store.loadUserFeed()
            }
        }
    }
}

#Preview {
    InitialView()
        .environmentObject(Store.mocked)
}
