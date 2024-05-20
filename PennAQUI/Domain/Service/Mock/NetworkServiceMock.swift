//
//  NetworkServiceMock.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

// TODO: Add mock scenarios

struct NetworkServiceMock: NetworkService {
    func getFeed(forCity city: CityInput) async -> Result<FeedData, NetworkError> {
        .success(
            FeedData(
                status: .ok,
                cityStationID: 4,
                airQualityIndex: 189,
                time: .now,
                cityData: CityData(
                    name: city.description,
                    lat: 20.2811,
                    long: 24.9382,
                    logoURL: nil
                ),
                stationInfo: StationInfo(
                    url: nil,
                    name: "Mordor Meteorology",
                    logoURL: nil
                ),
                feedCategory: .city,
                forecast: ForecastData(
                    tomorrowPM25: "123",
                    dayAfterPM25: "456"
                )
            )
        )
    }

    func getFeed(forUser user: UserCoordinates) async -> Result<FeedData, NetworkError> {
        .success(
            FeedData(
                status: .ok,
                cityStationID: 12,
                airQualityIndex: 240,
                time: .now,
                cityData: CityData(
                    lat: user.latitude,
                    long: user.longitude
                ),
                stationInfo: StationInfo(
                    url: nil,
                    name: "Mordor Meteorology",
                    logoURL: nil
                ),
                feedCategory: .user,
                forecast: ForecastData(
                    tomorrowPM25: "500",
                    dayAfterPM25: "222"
                )
            )
        )
    }
}
