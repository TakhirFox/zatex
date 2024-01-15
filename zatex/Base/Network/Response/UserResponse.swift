//
//  UserResponse.swift
//  zatex
//
//  Created by Zakirov Tahir on 15.01.2024.
//

import Foundation

struct UserResponse: Decodable {
    let id: Int
    let storeName: String
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let banner: String
    let gravatar: GravatarUnion?
    let productsPerPage: Int
    let registered: String

    enum CodingKeys: String, CodingKey {
        case id
        case storeName = "store_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case email, phone
        case banner
        case gravatar
        case productsPerPage = "products_per_page"
        case registered
    }
    
    enum GravatarUnion: Decodable {
        
        case avatar(String)
        case empty(Bool)
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(Bool.self) {
                self = .empty(x)
                return
            }
            if let x = try? container.decode(String.self) {
                self = .avatar(x)
                return
            }
            throw DecodingError.typeMismatch(GravatarUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for GravatarUnion"))
        }
    }
}
