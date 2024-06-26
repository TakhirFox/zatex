//
//  ChatListResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import Foundation

struct ChatListResult: Decodable {
    let chatID, user1ID, user2ID, productID: String?
    let content, sentAt, postTitle: String?
    let firstName: String?
    let lastName: String?
    let isRead: Bool?
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case chatID = "chat_id"
        case user1ID = "user1_id"
        case user2ID = "user2_id"
        case productID = "product_id"
        case content
        case sentAt = "sent_at"
        case postTitle = "post_title"
        case firstName = "first_name"
        case lastName = "last_name"
        case isRead = "is_read"
        case avatar
    }
}
