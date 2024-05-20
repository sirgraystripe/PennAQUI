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
    @Environment(\.scenePhase) private var scenePhase

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
            .onChange(of: scenePhase) { _, scenePhase in
                switch scenePhase {
                case .background, .inactive:
                    LocationManager.shared.stopMonitoringLocation()
                default: break
                }
            }
    }
}

#Preview {
    RootView()
}
