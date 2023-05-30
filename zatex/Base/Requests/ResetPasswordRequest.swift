//
//  ResetPasswordRequest.swift
//  zatex
//
//  Created by Zakirov Tahir on 30.05.2023.
//

import Foundation

struct ResetPasswordRequest: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case userLogin = "user_login"
    }
    
    let userLogin: String
    
}
