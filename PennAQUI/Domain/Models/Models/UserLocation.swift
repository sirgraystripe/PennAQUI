//
//  UserLocation.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/19/24.
//

import Foundation

struct UserCoordinates: Equatable, CustomStringConvertible {
    var latitude: Double
    var longitude: Double

    var description: String {
        "(\(latitude), \(longitude)"
    }
}
