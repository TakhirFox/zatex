//
//  CheckChatReviewResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 02.05.2023.
//

import Foundation

struct CheckChatReviewResult: Decodable {
    let success: Bool?
    let chat_id: String?
    let user1_id: String?
    let user2_id: String?
    let product_id: String?
}
