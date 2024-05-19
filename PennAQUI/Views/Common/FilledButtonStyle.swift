//
//  FilledButtonStyle.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/19/24.
//

import SwiftUI

struct FilledButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    var color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .foregroundStyle(.white)
            .background {
                RoundedRectangle(cornerRadius: Theme.constants.cornerRadius)
                    .foregroundStyle(
                        isEnabled ? color : color.opacity(0.4)
                    )
            }
    }
}

#Preview {
    Button("Hello, World!") {}
        .buttonStyle(FilledButtonStyle(color: .blue))
        .disabled(true)
}
