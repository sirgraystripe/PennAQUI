//
//  Store.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Combine
import Foundation

class Store: ObservableObject {
    // MARK: Data

    @Published var feedData = [FeedCategory: FeedData]()
    @Published var activeFeed: FeedData = .empty()
    @Published var presentOnboarding = false

    var cancellable: AnyCancellable? = nil

    // MARK: Utilities

    var service: NetworkService

    init(service: NetworkService) {
        self.service = service

        cancellable = LocationManager.shared.$userCoordinates
            .compactMap { $0 }
            .throttle(for: 10, scheduler: RunLoop.main, latest: true)
            .removeDuplicates()
            .sink { userCoordinates in
                Task { [weak self] in
                    await self?.loadUserFeed(userCoordinates: userCoordinates)
                }
            }
    }

    func loadUserFeed(userCoordinates: UserCoordinates) async {
        switch await service.getFeed(forUser: userCoordinates) {
        case let .success(feedData):
            DispatchQueue.main.async {
                self.feedData[.user] = feedData
                self.setActiveFeed(.user)
                AQILogger.Network.info("Successfully got user feed data: \(String(describing: feedData))")
            }
        case let .failure(networkError):
            AQILogger.Network.error("Error fetching user feed: \(networkError.localizedDescription)")
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

        switch feedCategory {
        case .user: LocationManager.shared.startMonitoringLocationIfAuthorized()
        case .city: LocationManager.shared.stopMonitoringLocation()
        }

        activeFeed = feedData
    }
}

extension Store {
    static var mocked: Store {
        Store(service: NetworkServiceMock())
    }
}
