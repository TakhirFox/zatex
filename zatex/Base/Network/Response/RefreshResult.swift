//
//  RefreshResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.07.2024.
//

import Foundation

public struct RefreshResult: Decodable {
    
    let accessToken: String
    let expiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
    }
}
