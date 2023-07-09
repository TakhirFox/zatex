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
    let address: AddressUnion?
    let banner: String?
    let gravatar: String?
    let rating: StoreInfoResult.Rating?
    let registered: String?
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case storeName = "store_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case phone
        case address
        case banner
        case gravatar
        case rating
        case registered
        case email
    }
    
    enum AddressUnion: Decodable {
        
        case addressClass(StoreInfoResult.Address)
        case anythingArray([String])
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode([String].self) {
                self = .anythingArray(x)
                return
            }
            if let x = try? container.decode(StoreInfoResult.Address.self) {
                self = .addressClass(x)
                return
            }
            throw DecodingError.typeMismatch(AddressUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AddressUnion"))
        }
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
