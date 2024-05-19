//
//  NetworkService.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

protocol NetworkService {
    func getFeed(forCity city: CityInput) async -> Result<FeedData, NetworkError>
    func getFeed(forUser user: UserCoordinates) async -> Result<FeedData, NetworkError>
}
