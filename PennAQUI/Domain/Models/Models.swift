//
//  Models.swift
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
    var stationInfo: [StationInfo]?

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

        if let attributionsDTOs = data.attributions {
            stationInfo = attributionsDTOs.map { StationInfo(attributionsDTO: $0) }
        }
    }
}

/// Represents city data returned from the API.
/// Contrast this to `City`, which is meant for input.
struct CityData: Codable {
    var name: String?
    var lat: Int?
    var long: Int?
    var logoURL: URL?

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

struct StationInfo: Codable {
    var url: URL?
    var name: String?
    var logoURL: URL?

    init(attributionsDTO dto: AttributionsDTO) {
        if let urlString = dto.url,
           let url = URL(string: urlString)
        {
            self.url = url
        }
        name = dto.name

        if let urlString = dto.logo,
           let url = URL(string: urlString)
        {
            logoURL = url
        }
    }
}

enum City: Codable {
    /// e.g., `beijing`
    case name(String)
    /// e.g., `@7843`
    case id(String)
}
