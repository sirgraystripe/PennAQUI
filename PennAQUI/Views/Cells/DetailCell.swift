//
//  DetailCell.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/19/24.
//

import SwiftUI

struct DetailCell<Header: View, Content: View>: View {
    @ViewBuilder var header: Header
    @ViewBuilder var content: Content
    var alignment: HorizontalAlignment = .leading

    var body: some View {
        VStack(alignment: alignment) {
            header
            VStack(alignment: .leading) {
                content
            }
        }
        .cellBackground()
    }
}

/// A small helper view to get around the type erasure in `.labelStyle`
struct IconLabel: View {
    /// Not shown, but may be read over VO
    var title: String
    var systemImage: String
    var body: some View {
        Label(title, systemImage: systemImage)
            .labelStyle(.iconOnly)
    }
}

// MARK: Public Initializers

extension DetailCell where Header == Text {
    init(title: String, @ViewBuilder content: () -> Content) {
        header = Text(title)
            .font(Theme.fonts.body)
        self.content = content()
    }
}

extension DetailCell where Header == IconLabel {
    /// A centered icon-only rendition of a DetailCell. Title needed for a11y, but not displayed.
    init(
        title: String,
        systemImage: String,
        @ViewBuilder content: () -> Content
    ) {
        header = IconLabel(title: title, systemImage: systemImage)
        self.content = content()
        alignment = .center
    }
}
