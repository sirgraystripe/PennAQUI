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
