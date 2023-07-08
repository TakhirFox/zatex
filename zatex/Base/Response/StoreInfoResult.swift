//
//  StoreInfoResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 15.03.2023.
//

import Foundation

struct StoreInfoResult: Decodable {
    var id: Int?
    var storeName, firstName, lastName, phone: String?
    var address: AddressUnion?
    var banner: String?
    var gravatar: String?
    var rating: StoreInfoResult.Rating?
    var registered: String?
    var email: String?
    
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
        var street1, city, country: String?

        enum CodingKeys: String, CodingKey {
            case street1 = "street_1"
            case city, country
        }
    }

    struct Rating: Decodable {
        var rating: String?
        var count: Int?
    }

}

