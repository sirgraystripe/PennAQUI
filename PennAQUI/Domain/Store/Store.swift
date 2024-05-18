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

    @Published private var feedData: FeedData = .empty()

    // MARK: Utilities

    var service: NetworkService

    init(service: NetworkService) {
        self.service = service
    }

    func load(city: City) async {
        switch await service.getFeed(forCity: city) {
        case let .success(feedData):
            self.feedData = feedData
            AQILogger.Network.info("Successfully got feed data: \(String(describing: feedData))")
        case let .failure(networkError):
            AQILogger.Network.error("\(networkError.localizedDescription)")
        }
    }
}
