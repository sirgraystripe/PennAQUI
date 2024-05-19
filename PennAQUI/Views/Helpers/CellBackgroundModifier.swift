//
//  CellBackgroundModifier.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/19/24.
//

import SwiftUI

struct CellBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: Theme.constants.cornerRadius)
                    .stroke(lineWidth: 1.0)
                    .foregroundStyle(.gray)
            )
    }
}
