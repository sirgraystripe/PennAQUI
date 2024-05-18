//
//  StationInfo.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/18/24.
//

import Foundation

struct StationInfo: Codable {
    var url: URL?
    var name: String?
    var logoURL: URL?
}

extension StationInfo {
    init(attributionsDTO dto: AttributionsDTO) {
        if let urlString = dto.url,
           let url = URL(string: urlString)
        {
            self.url = url
        }
        name = dto.name

        if let urlString = dto.logo,
           let url = URL(string: urlString)
        {
            logoURL = url
        }
    }
}
