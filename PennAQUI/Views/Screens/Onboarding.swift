//
//  Onboarding.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/19/24.
//

import SwiftUI

struct Onboarding: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.dismiss) private var dismiss

    @ObservedObject private var locationManager = LocationManager.shared

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cloud.fog.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
            Text("PennAQUI")
                .font(Theme.fonts.bigTitle)
            VStack {
                Text("Location was in the spec, so...")
                    .font(Theme.fonts.title)
            }
            if locationManager.locationPermissions == .denied {
                Text("Open Settings to enable Location.")
                    .font(Theme.fonts.title)
                Button("I'll do it this time...") {
                    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
                        AQILogger.UI.error("Invalid settingsURL.")
                        return
                    }
                    UIApplication.shared.open(settingsURL)
                }
                .buttonStyle(.filled(color: .blue))
            } else {
                Button("I'll Allow Location", systemImage: "arrow.right") {
                    locationManager.startMonitoringLocationWithRequest()
                }
                .buttonStyle(.filled(color: .black))
            }
            Spacer()
        }
        .padding(Theme.constants.size50)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    Onboarding()
}
