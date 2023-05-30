//
//  AuthResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.03.2023.
//

import Foundation

public struct AuthResult: Codable {
    let userId, token, userEmail, userNicename, userDisplayName: String?

    public enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case token
        case userEmail = "user_email"
        case userNicename = "user_nicename"
        case userDisplayName = "user_display_name"
    }
}
