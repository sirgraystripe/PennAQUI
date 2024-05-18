//
//  City.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

enum City: Codable {
    /// e.g., `beijing`
    case name(String)
    /// e.g., `@7843`
    case id(String)
}
