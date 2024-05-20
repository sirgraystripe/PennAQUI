//
//  Onboarding.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/19/24.
//

import SwiftUI

struct Onboarding: View {
    @Environment(\.dismiss) private var dismiss
    var onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("PennAQUI")
                .font(Theme.fonts.bigTitle)
            Text("Enable location permissions. (We really need it!)")
                .font(Theme.fonts.title)
                .multilineTextAlignment(.center)
            Spacer()
            Button("I Will", systemImage: "arrow.right") {
                LocationManager.shared.startMonitoringLocationWithRequest()
                dismiss()
                onDismiss()
            }
            .buttonStyle(.filled(color: .black))
        }
        .padding(Theme.constants.size50)
    }
}

#Preview {
    Onboarding {}
}
