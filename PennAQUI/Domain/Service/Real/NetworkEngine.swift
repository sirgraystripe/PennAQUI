//
//  NetworkEngine.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

class NetworkEngine: NetworkService {
    func getFeed(forCity city: CityInput) async -> Result<FeedData, NetworkError> {
        let result = await performRequest(to: Endpoint.feed(city: city))

        let data: Data

        // Until typed throws land in Swift, this bubbles up failures
        switch result {
        case let .success(responseData): data = responseData
        case let .failure(failure): return .failure(failure)
        }

        let feedDTO: FeedDTO
        do {
            feedDTO = try JSONDecoder().decode(FeedDTO.self, from: data)
        } catch {
            return .failure(.jsonParseError(error.localizedDescription))
        }

        return .success(FeedData(feedDTO: feedDTO, category: .city))
    }

    func getFeed(forUser user: UserCoordinates) async -> Result<FeedData, NetworkError> {
        let result = await performRequest(to: Endpoint.feed(user: user))

        let data: Data
        switch result {
        case let .success(responseData): data = responseData
        case let .failure(failure): return .failure(failure)
        }

        let feedDTO: FeedDTO
        do {
            feedDTO = try JSONDecoder().decode(FeedDTO.self, from: data)
        } catch {
            // Attempt to extract an error
            if let errorDTO = try? JSONDecoder().decode(FeedErrorDTO.self, from: data) {
                return .failure(.sessionError(errorDTO.errorString ?? "Server did not describe error."))
            } else {
                return .failure(.jsonParseError(error.localizedDescription))
            }
        }

        return .success(FeedData(feedDTO: feedDTO, category: .user))
    }

    // MARK: Helpers

    private func performRequest(to endpoint: Endpoint.EndpointResult) async -> Result<Data, NetworkError> {
        let url: URL
        switch endpoint {
        case let .success(endpointURL): url = endpointURL
        case let .failure(error): return .failure(error)
        }

        do {
            let data = try await URLSession.shared.data(from: url).0
            return .success(data)
        } catch {
            return .failure(.sessionError(error.localizedDescription))
        }
    }
}
