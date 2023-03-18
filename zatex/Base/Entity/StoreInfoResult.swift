//
//  StoreInfoResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 15.03.2023.
//

import Foundation

struct StoreInfoResult: Decodable {
    let id: Int?
    let storeName, firstName, lastName, phone: String?
    let address: StoreInfoResult.Address?
    let banner: String?
    let gravatar: String?
    let rating: StoreInfoResult.Rating?
    let registered: String?

    enum CodingKeys: String, CodingKey {
        case id
        case storeName = "store_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case phone, address, banner, gravatar, rating, registered
    }
    
    struct Address: Decodable {
        let street1, city, country: String?

        enum CodingKeys: String, CodingKey {
            case street1 = "street_1"
            case city, country
        }
    }

    struct Rating: Decodable {
        let rating: String?
        let count: Int?
    }

}

