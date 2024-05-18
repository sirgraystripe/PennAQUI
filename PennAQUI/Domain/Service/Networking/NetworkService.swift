//
//  NetworkService.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

protocol NetworkService {
    func getFeed(forCity city: City) async -> Result<FeedData, NetworkError>
}
