//
//  AuthRequest.swift
//  zatex
//
//  Created by Zakirov Tahir on 30.05.2023.
//

import Foundation

struct AuthRequest: Encodable {
    let username: String
    let password: String
}
