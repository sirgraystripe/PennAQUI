//
//  ActionMenu.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/19/24.
//

import SwiftUI

struct ActionMenu: View {
    @Environment(\.isEnabled) private var isEnabled

    var body: some View {
        VStack(alignment: .leading) {
            Button {
                // TODO: Add city call
            } label: {
                Label("Add City", systemImage: "plus.circle.fill")
            }
            .disabled(isEnabled)
            .buttonStyle(.filled(color: .blue))
            HStack {
                Button {
                    // TODO: Show city list drawer
                } label: {
                    Label("Select city...", systemImage: "building.2")
                }
                .disabled(isEnabled)
                .buttonStyle(.filled(color: .blue))
            }
        }
    }
}

#Preview {
    ActionMenu()
}
