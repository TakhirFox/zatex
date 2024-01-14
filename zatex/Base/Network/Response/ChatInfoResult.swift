//
//  ChatInfoResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 11.04.2023.
//

import Foundation

struct ChatInfoResult: Decodable {
    let firstName: String?
    let lastName: String?
    let authorProduct: String?
    let productID: String?
    let authorID: String?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case authorProduct
        case imageURL = "imageUrl"
        case productID
        case authorID
    }
}
