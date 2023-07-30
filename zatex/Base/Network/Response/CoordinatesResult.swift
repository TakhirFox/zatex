//
//  CoordinatesResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 04.04.2023.
//

import Foundation

struct CoordinatesResult: Decodable {
    let placeID: Int?
    let lat, lon, displayName: String?

    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case lat, lon
        case displayName = "display_name"
    }
}
