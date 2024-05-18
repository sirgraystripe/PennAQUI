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

/// Also gives back a `debug` obj with `sync` (ISO 8601) timestamp
/// not in docs, ignoring it for now.
struct DataDTO: Codable {
    var idx: Int?
    var aqi: Int?
    var time: TimeDTO?
    var city: CityDTO?
    var attributions: [AttributionsDTO]?
    // TODO: Leaving these out for now
//    var iaqi: IAQIDTO?
//    var forecast: ForecastDTO?
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
    var geo: [Int]?
    var url: String?
}

struct TimeDTO: Codable {
    var s: String?
    var tz: String?
}
