//
//  LatLongCell.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/19/24.
//

import SwiftUI

struct LatLongCell: View {
    @EnvironmentObject private var store: Store

    var body: some View {
        VStack(alignment: .leading) {
            Text("LAT/LONG")
                .font(Theme.fonts.body)
            Text("\(store.feedData.cityData?.lat ?? 0.0)")
                .font(Theme.fonts.title)
            Text("\(store.feedData.cityData?.long ?? 0.0)")
                .font(Theme.fonts.title)
        }
        .cellBackground()
    }
}

#Preview {
    LatLongCell()
        .environmentObject(Store.mocked)
}
