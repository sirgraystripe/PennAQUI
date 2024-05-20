//
//  FeedDTO.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

struct FeedDTO: Codable {
    var status: String?
    var data: DataDTO?
}

/// Fallback for presented errors due to type constraints
struct FeedErrorDTO: Codable {
    var status: String?
    var errorString: String?

    enum CodingKeys: String, CodingKey {
        case status
        case errorString = "data"
    }
}

/// Also gives back a `debug` obj with `sync` (ISO 8601) timestamp
/// not in docs, ignoring it for now.
struct DataDTO: Codable {
    var idx: Int?
    var aqi: Int?
    var time: TimeDTO?
    var city: CityDTO?
    var attributions: [AttributionsDTO]?
    var forecast: ForecastDTO?
    // Not needed.
//    var iaqi: IAQIDTO?
}

/// EPA Attributions, not documented
struct AttributionsDTO: Codable {
    var url: String?
    var name: String?
    var logo: String?
}

/// Also returns a `location` field, not in docs, empty.
struct CityDTO: Codable {
    var name: String?
    var geo: [Double]?
    var url: String?
}

struct TimeDTO: Codable {
    var s: String?
    var tz: String?
}

struct ForecastDTO: Codable {
    var daily: DailyForecastDTO?
}

struct DailyForecastDTO: Codable {
    var pm25: [ForecastElementDTO]?
    var pm10: [ForecastElementDTO]?
    var o3: [ForecastElementDTO]?
    var uvi: [ForecastElementDTO]?
}

struct ForecastElementDTO: Codable {
    var avg: Int?
    var day: String?
    var max: Int?
    var min: Int?
}
