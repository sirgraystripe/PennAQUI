//
//  NewProjectApp.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import SwiftUI

@main
struct PennAQUIApp: App {
    @StateObject private var store = Store(service: ServiceEngine())

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .environmentObject(store)
    }
}
