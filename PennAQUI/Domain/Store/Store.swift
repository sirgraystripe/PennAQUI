//
//  Store.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

class Store: ObservableObject {
    var service: Service

    init(service: Service) {
        self.service = service
    }
}
