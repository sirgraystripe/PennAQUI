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
                self.setActiveFeed(.user)
                AQILogger.Network.info("Successfully got user feed data: \(String(describing: feedData))")
            }
        case let .failure(networkError):
            AQILogger.Network.error("\(networkError.localizedDescription)")
        }
    }

    func addCityFeed(_ feed: FeedData) {
        feedData[.city] = feed
    }

    func setActiveFeed(_ feedCategory: FeedCategory) {
        guard let feedData = feedData[feedCategory] else {
            AQILogger.UI.error("Attempt to switch to \(feedCategory.rawValue), but its data does not exist.")
            return
        }
        activeFeed = feedData
    }
}

extension Store {
    static var mocked: Store {
        Store(service: NetworkServiceMock())
    }
}
