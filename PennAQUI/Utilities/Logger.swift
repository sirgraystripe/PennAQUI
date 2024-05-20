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
        case ui
        case location

        var description: String {
            "me.peterkos.PennAQUI.subsystem.\(rawValue.capitalized)"
        }
    }

    static var Network: Logger {
        Logger(subsystem: Subsystem.networking.description, category: "")
    }

    static var UI: Logger {
        Logger(subsystem: Subsystem.ui.description, category: "")
    }

    static var Location: Logger {
        Logger(subsystem: Subsystem.location.description, category: "")
    }
}
