//
//  ActionMenu.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/19/24.
//

import SwiftUI

struct ActionMenu: View {
    @EnvironmentObject private var store: Store
    @Environment(\.isEnabled) private var isEnabled

    @State private var presentAddCitySheet = false
    @State private var feedCategory: FeedCategory = .user

    private var cityAdded: Bool {
        store.feedData[.city] != nil
    }

    var body: some View {
        VStack(alignment: .leading) {
            Button {
                presentAddCitySheet.toggle()
            } label: {
                Label("Add City", systemImage: "plus.circle.fill")
            }
            .buttonStyle(.filled(color: .blue))
            if cityAdded {
                Picker("Feed", selection: $feedCategory) {
                    Image(systemName: "location.viewfinder")
                        .resizable()
                        .tag(FeedCategory.user)
                    Image(systemName: "building.2")
                        .resizable()
                        .tag(FeedCategory.city)
                }
                .pickerStyle(.palette)
            }
        }
        .onChange(of: feedCategory) { _, feedCategory in
            store.setActiveFeed(feedCategory)
        }
        .sheet(isPresented: $presentAddCitySheet) {
            let cityDataExists = store.feedData[.city] != nil
            feedCategory =  cityDataExists ? .city : .user
        } content: {
            AddCitySheet()
                .presentationDetents([.medium, .large])

        }
    }
}

#Preview {
    InitialView()
        .environmentObject(Store.mocked)
}
