//
//  NetworkError.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

enum NetworkError: Error {
    case invalidBaseURL
    case invalidURL
    case missingToken
    case sessionError(String)
    case jsonParseError(String)
}
