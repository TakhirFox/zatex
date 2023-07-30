//
//  CoordinatesResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 04.04.2023.
//

import Foundation

struct CoordinatesResult: Decodable {
    
    struct Address: Decodable {
        let road: String?
        let city: String?
        let houseNumber: String?
        
        enum CodingKeys: String, CodingKey {
            case road
            case city
            case houseNumber = "house_number"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case lat, lon
        case displayName = "display_name"
        case address
    }
    
    let placeID: Int?
    let lat: String?
    let lon: String?
    let displayName: String?
    let address: Address?
}
