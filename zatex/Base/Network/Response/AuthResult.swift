//
//  AuthResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.03.2023.
//

import Foundation

public struct AuthResult: Decodable {
    
    struct Data: Decodable {
        let userLogin: String
        let userNicename: String
        let userEmail: String
        let userRegistered: String
        let displayName: String
        
        enum CodingKeys: String, CodingKey {
            case userLogin = "user_login"
            case userNicename = "user_nicename"
            case userEmail = "user_email"
            case userRegistered = "user_registered"
            case displayName = "display_name"
        }
    }
    
    struct User: Decodable {
        let data: Data
        let id: Int
        
        enum CodingKeys: String, CodingKey {
            case data
            case id = "ID"
        }
    }
    
    let user: User
    let accessToken: String?
    let expiresIn: Int
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case user = "wp_user"
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
    }
}
