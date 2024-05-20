//
//  RootView.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var store: Store
    @AppStorage("firstLaunch") private var firstLaunch: Bool = true

    var body: some View {
        InitialView()
            .sheet(isPresented: $store.presentOnboarding) {
                Onboarding {
                    firstLaunch = false
                }
            }
            .onChange(of: firstLaunch, initial: true) { _, firstLaunch in
                store.presentOnboarding = firstLaunch
            }
    }
}

#Preview {
    RootView()
}
