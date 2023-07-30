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
    let gravatar: GravatarUnion?
    let rating: StoreInfoResult.Rating?
    let registered: String?
    let email: String?
    let isShop: Bool?
    
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
        case isShop = "featured"
    }
    
    enum AddressUnion: Decodable {
        
        case address(StoreInfoResult.Address)
        case empty([String])
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode([String].self) {
                self = .empty(x)
                return
            }
            if let x = try? container.decode(StoreInfoResult.Address.self) {
                self = .address(x)
                return
            }
            throw DecodingError.typeMismatch(AddressUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AddressUnion"))
        }
    }
    
    enum GravatarUnion: Decodable {
        
        case addressClass(String)
        case anythingBool(Bool)
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(Bool.self) {
                self = .anythingBool(x)
                return
            }
            if let x = try? container.decode(String.self) {
                self = .addressClass(x)
                return
            }
            throw DecodingError.typeMismatch(GravatarUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for GravatarUnion"))
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
