//
//  FeedData.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

struct FeedData: Codable {
    enum Status: String, Codable {
        case ok
        case error
    }

    var status: Status?
    var cityStationID: Int?
    var airQualityIndex: Int?
    var time: Date?
    var cityData: CityData?
    var stationInfo: StationInfo?
}

extension FeedData {
    init(feedDTO dto: FeedDTO) {
        if let status = dto.status {
            self.status = .init(rawValue: status)
        }

        guard let data = dto.data else {
            return
        }
        cityStationID = data.idx
        airQualityIndex = data.aqi

        let formatStyle = Date.FormatStyle()
            .year(.defaultDigits)
            .month(.twoDigits)
            .day(.twoDigits)
            .hour(.twoDigits(amPM: .omitted))
            .minute(.twoDigits)
            .second(.twoDigits)
            .timeZone(.localizedGMT(.long))

        if let timestamp = data.time?.s,
           let timeZone = data.time?.tz
        {
            time = try? Date("\(timestamp) \(timeZone)", strategy: formatStyle)
        }

        if let cityDTO = data.city {
            cityData = CityData(cityDTO: cityDTO)
        }

        // Seems to return the org as an attribution after; for now, just pulling the first out
        if let attributionsDTO = data.attributions?.first {
            stationInfo = StationInfo(attributionsDTO: attributionsDTO)
        }
    }
}
