//
//  CheckChatResponse.swift
//  zatex
//
//  Created by Zakirov Tahir on 12.03.2023.
//

import Foundation

struct CheckChatResponse: Encodable {
    let authorId: String
    let productId: String
    
    enum CodingKeys: String, CodingKey {
        case authorId = "user2_id"
        case productId = "product_id"
    }
}
