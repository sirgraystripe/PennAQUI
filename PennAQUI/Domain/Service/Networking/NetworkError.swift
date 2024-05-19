//
//  NetworkError.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidBaseURL
    case invalidURL
    case missingToken
    case sessionError(String)
    case jsonParseError(String)
    case notImplemented(String)

    var errorDescription: String? {
        switch self {
        case .invalidBaseURL:
            "Base URL is incorrect."
        case .invalidURL:
            "Could not get URL to form request."
        case .missingToken:
            "Missing API token."
        case let .sessionError(string):
            "Session error: \(string)"
        case let .jsonParseError(string):
            "JSON parse error: \(string)"
        case let .notImplemented(string):
            "Not implemented: \(string)"
        }
    }
}
