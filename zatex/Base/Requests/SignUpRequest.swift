//
//  SignUpRequest.swift
//  zatex
//
//  Created by Zakirov Tahir on 30.05.2023.
//

import Foundation

struct SignUpRequest: Encodable {
    let username: String
    let email: String
    let password: String
    let role: String
}
