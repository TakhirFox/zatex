//
//  SendMessageResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 12.03.2023.
//

import Foundation

struct SendMessageResult: Decodable {
    let success: Bool?
    let messageId: Int?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case messageId = "message_id"
    }
}
