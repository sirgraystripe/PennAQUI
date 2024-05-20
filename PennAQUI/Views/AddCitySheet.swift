//
//  AddCitySheet.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/19/24.
//

import SwiftUI

struct AddCitySheet: View {
    @EnvironmentObject private var store: Store
    @Environment(\.dismiss) private var dismiss

    @State private var searchQuery = ""
    @State private var feedResult: FeedData?

    private var cityName: String {
        feedResult?.cityData?.name ?? ""
    }

    var body: some View {
        NavigationStack {
            VStack {
                Text(cityName)
                    .font(Theme.fonts.title)
                Button("Add \(cityName)") {
                    if let feedResult {
                        store.addCityFeed(feedResult)
                        dismiss()
                    }
                }
                .butonStyle(.filled(color: .black))
                .disabled(feedResult == nil)
            }
            // Title size is a little finicky
            .navigationTitle("Add City")
        }
        .searchable(
            text: $searchQuery,
            placement: .toolbar,
            prompt: "Seattle..."
        )
        .onSubmit(of: .search) {
            Task {
                // TODO: Support ID search
                await fetchCity(.name(searchQuery))
            }
        }
    }

    func fetchCity(_ city: CityInput) async {
        let result = await store.service.getFeed(forCity: city)

        switch result {
        case let .success(success):
            Task { @MainActor in
                feedResult = success
            }
        case let .failure(failure):
            AQILogger.UI.error("Failed to fetch city with error: \(failure)")
        }
    }
}

#Preview {
    ActionMenu()
}
