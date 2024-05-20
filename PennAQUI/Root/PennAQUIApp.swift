//
//  PennAQUIApp.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import SwiftUI

@main
struct PennAQUIApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var store = Store(service: NetworkEngine())
    // Mocked:
//    @StateObject private var store = Store.mocked

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
                .onChange(of: scenePhase) { _, scenePhase in
                    switch scenePhase {
                    case .background, .inactive:
                        LocationManager.shared.stopMonitoringLocation()
                    case .active:
                        LocationManager.shared.startMonitoringLocationIfAuthorized()
                    @unknown default:
                        break
                    }
                }
        }
    }
}
