//
//  RootView.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var store: Store
    @ObservedObject private var locationManager = LocationManager.shared

    var body: some View {
        InitialView()
            .sheet(isPresented: $store.presentOnboarding) {
                Onboarding()
                    .interactiveDismissDisabled()
            }
            .onChange(of: locationManager.locationPermissions, initial: true) { _, locationPermissions in
                store.presentOnboarding = locationPermissions != .granted
            }
    }
}

#Preview {
    RootView()
        .environmentObject(Store.mocked)
}
