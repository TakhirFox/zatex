//
//  ChatMessageResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import Foundation

struct ChatMessageResult: Decodable {
    let messageID, senderID, receiverID, content: String?
    let sentAt: String?

    enum CodingKeys: String, CodingKey {
        case messageID = "message_id"
        case senderID = "sender_id"
        case receiverID = "receiver_id"
        case content
        case sentAt = "sent_at"
    }
}
