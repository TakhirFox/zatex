//
//  AuthResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.03.2023.
//

import Foundation

struct AuthResult: Codable {
    let token, userEmail, userNicename, userDisplayName: String?

    enum CodingKeys: String, CodingKey {
        case token
        case userEmail = "user_email"
        case userNicename = "user_nicename"
        case userDisplayName = "user_display_name"
    }
}
