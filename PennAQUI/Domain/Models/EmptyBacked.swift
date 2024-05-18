//
//  EmptyBacked.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

/// This convenience lets us have domain-defined
/// fallbacks for loading states where it makes sense:
/// - Values that are reasonably not `0` are set to 0
/// - Reasonable assumptions made (e.g., `.error`)
/// - All others passed on as nil to be handled in view

protocol EmptyBacked {
    associatedtype T
    static func empty() -> T
}

extension FeedData: EmptyBacked {
    static func empty() -> Self {
        .init(
            status: .error,
            cityStationID: 0,
            airQualityIndex: nil,
            time: nil,
            cityData: .empty(),
            stationInfo: nil
        )
    }
}

extension CityData: EmptyBacked {
    static func empty() -> Self {
        .init(
            name: "",
            lat: 0,
            long: 0,
            logoURL: nil
        )
    }
}
