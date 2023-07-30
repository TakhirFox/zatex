//
//  SignUpResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 29.05.2023.
//

import Foundation

struct SignUpResult: Decodable {
    let code: Int?
    let message, token, userEmail, userNicename, userID: String?

    enum CodingKeys: String, CodingKey {
        case code, message, token
        case userEmail = "user_email"
        case userNicename = "user_nicename"
        case userID = "user_id"
    }
}
