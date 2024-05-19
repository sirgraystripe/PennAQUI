//
//  Store.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation
import OSLog

class Store: ObservableObject {
    // MARK: Data

    enum FeedCategory {
        case city
        case user
    }

    @Published var feedData = [FeedCategory: FeedData]()
    @Published var activeFeed: FeedData = .empty()

    // MARK: Utilities

    var service: NetworkService

    init(service: NetworkService) {
        self.service = service
    }

    func loadUserFeed() async {
        switch await service.getFeed(forUser: .init(latitude: 0, longitude: 0)) {
        case let .success(feedData):
            Task { @MainActor in
                self.feedData[.user] = feedData
                AQILogger.Network.info("Successfully got user feed data: \(String(describing: feedData))")
            }
        case let .failure(networkError):
            AQILogger.Network.error("\(networkError.localizedDescription)")
        }
    }

    func addCityFeed(_ feed: FeedData) {
        feedData[.city] = feed
    }
}

extension Store {
    static var mocked: Store {
        Store(service: NetworkServiceMock())
    }
}
