//
//  CityData.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

/// Represents city data returned from the API.
/// Contrast this to `City`, which is meant for input.
struct CityData: Codable {
    var name: String?
    var lat: Double?
    var long: Double?
    var logoURL: URL?
}

extension CityData {
    init(cityDTO dto: CityDTO) {
        name = dto.name
        // Assuming lat/long is the order
        lat = dto.geo?[safe: 0]
        long = dto.geo?[safe: 1]
        if let urlString = dto.url,
           let logoURL = URL(string: urlString)
        {
            self.logoURL = logoURL
        }
    }
}
