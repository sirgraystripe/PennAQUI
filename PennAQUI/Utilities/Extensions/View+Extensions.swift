//
//  View+Extensions.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/19/24.
//

import SwiftUI

extension View {
    func cellBackground() -> some View {
        modifier(CellBackgroundModifier())
    }
}

extension ButtonStyle where Self == FilledButtonStyle {
    static func filled(color: Color) -> FilledButtonStyle {
        FilledButtonStyle(color: color)
    }
}
