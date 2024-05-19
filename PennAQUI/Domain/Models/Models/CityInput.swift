//
//  CityInput.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

enum CityInput: Codable {
    /// e.g., `beijing`
    case name(String)
    /// e.g., `@7843`
    case id(String)

    var description: String {
        switch self {
        case let .name(name): name
        case let .id(id): id
        }
    }
}
