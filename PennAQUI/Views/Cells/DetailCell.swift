//
//  DetailCell.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/19/24.
//

import SwiftUI

struct DetailCell<Content: View>: View {
    var title: String

    @ViewBuilder
    var content: Content

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(Theme.fonts.body)
            VStack(alignment: .leading) {
                content
            }
        }
        .cellBackground()
    }
}
