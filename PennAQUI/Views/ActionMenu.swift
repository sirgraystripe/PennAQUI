//
//  ActionMenu.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/19/24.
//

import SwiftUI

struct ActionMenu: View {
    @Environment(\.isEnabled) private var isEnabled
    @State private var presentAddCitySheet = false

    var body: some View {
        VStack(alignment: .leading) {
            Button {
                presentAddCitySheet.toggle()
            } label: {
                Label("Add City", systemImage: "plus.circle.fill")
            }
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
        .sheet(isPresented: $presentAddCitySheet) {
            AddCitySheet {}
                .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    ActionMenu()
}
