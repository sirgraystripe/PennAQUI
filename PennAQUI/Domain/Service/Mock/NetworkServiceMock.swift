//
//  NetworkServiceMock.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

// TODO: Add mock scenarios

struct NetworkServiceMock: NetworkService {
    func getFeed(forCity _: City) async -> Result<FeedData, NetworkError> {
        .success(
            FeedData(
                status: .ok,
                cityStationID: 12,
                airQualityIndex: 24,
                time: .now,
                cityData: CityData(
                    name: "The Shire",
                    lat: 20.2811,
                    long: 24.9382,
                    logoURL: nil
                ),
                stationInfo: [StationInfo(
                    url: nil,
                    name: "Mordor Meterology",
                    logoURL: nil
                )]
            )
        )
    }
}
