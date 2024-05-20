//
//  ForecastData.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/20/24.
//

import Foundation

/// Only returning pm25 for now.
struct ForecastData: Codable {
    var yesterdayPM25: Int?
    var tomorrowPM25: Int?
}
extension ForecastData {
    init(forecastDTO dto: ForecastDTO) {
        guard let pm25 = dto.daily?.pm25 else {
            return
        }
        // API returns 2 days prior, then today
        yesterdayPM25 = pm25[safe: 1]?.avg
        tomorrowPM25 = pm25[safe: 3]?.avg
    }
}
