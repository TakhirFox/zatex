//
//  RefreshRequest.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.07.2024.
//

import Foundation

struct RefreshRequest: Encodable {
    let token: String
    let client_name: String
}
