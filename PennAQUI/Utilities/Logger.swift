//
//  Logger.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation
import OSLog

class AQILogger {
    private enum Subsystem: String, CustomStringConvertible {
        case networking

        var description: String {
            rawValue.capitalized
        }
    }

    static var Network: Logger {
        Logger(subsystem: Subsystem.networking.description, category: "")
    }
}
