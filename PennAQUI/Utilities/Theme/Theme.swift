//
//  Theme.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import SwiftUI

enum Theme {
    typealias colors = ThemeColors
    typealias fonts = ThemeFonts
    typealias constants = ThemeConstants
}

enum ThemeColors {}

enum ThemeFonts {
    private static var headerFontName: String {
        "Avenir"
    }

    // MARK: Fonts

    static var gigantic: Font {
        .custom(headerFontName, size: 80)
            .bold()
    }

    static var bigTitle: Font {
        .custom(headerFontName, size: 40, relativeTo: .title)
            .bold()
    }

    static var title: Font {
        .custom(headerFontName, size: 20, relativeTo: .title)
            .bold()
    }

    static var body: Font {
        .custom(headerFontName, size: 15, relativeTo: .body)
            .bold()
    }

    // MARK: Other

    /// Used for font properties
    static var giganticUIFont: UIFont {
        UIFont(name: "Avenir", size: 80) ?? .systemFont(ofSize: 80)
    }
}

enum ThemeConstants {
    static var cornerRadius: CGFloat = 4.0

    static var size50: CGFloat = 50
}
