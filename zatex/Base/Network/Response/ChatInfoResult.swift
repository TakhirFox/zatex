//
//  ChatInfoResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 11.04.2023.
//

import Foundation

struct ChatInfoResult: Decodable {
    let authorProduct: String?
    let authorUsername: String?
    let productID: String?
    let authorID: String?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case authorProduct, authorUsername
        case imageURL = "imageUrl"
        case productID
        case authorID
    }
}
