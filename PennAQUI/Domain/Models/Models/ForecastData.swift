//
//  ForecastData.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/20/24.
//

import Foundation

/// Only returning pm25 for now.
struct ForecastData: Codable {
    var tomorrowPM25: String?
    var dayAfterPM25: String?
}
extension ForecastData {
    init(forecastDTO dto: ForecastDTO) {
        tomorrowPM25 = dto.daily?[safe: 0]?.pm25
        dayAfterPM25 = dto.daily?[safe: 1]?.pm25
    }
}
