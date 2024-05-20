//
//  Endpoint.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

enum Endpoint {
    typealias EndpointResult = Result<URL, NetworkError>

    static var token: String? {
        Bundle.main.object(forInfoDictionaryKey: "AQI_API_TOKEN") as? String
    }

    private static var base: EndpointResult {
        if let url = URL(string: "https://api.waqi.info/") {
            .success(url)
        } else {
            .failure(.invalidBaseURL)
        }
    }

    static func feed(city: CityInput) -> EndpointResult {
        guard var base = try? base.get() else {
            return .failure(.invalidURL)
        }
        base.append(path: "feed")
        // Grr, case let.
        switch city {
        case let .name(name):
            base.append(path: name)
        case let .id(id):
            base.append(path: id)
        }

        guard let token else {
            return .failure(.missingToken)
        }
        base.append(queryItems: [.init(name: "token", value: token)])
        return .success(base)
    }

    static func feed(user: UserCoordinates) -> EndpointResult {
        guard var base = try? base.get() else {
            return .failure(.invalidURL)
        }
        // What a strange API.
        base.append(path: "feed")
        base.append(path: "geo:\(user.latitude);\(user.longitude)")

        guard let token else {
            return .failure(.missingToken)
        }
        base.append(queryItems: [.init(name: "token", value: token)])
        return .success(base)
    }
}
