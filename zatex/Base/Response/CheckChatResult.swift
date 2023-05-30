//
//  CheckChatResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 12.03.2023.
//

import Foundation

struct CheckChatResult: Decodable {
    let success: Bool?
    let chatID: String?

    enum CodingKeys: String, CodingKey {
        case success
        case chatID = "chat_id"
    }
}
