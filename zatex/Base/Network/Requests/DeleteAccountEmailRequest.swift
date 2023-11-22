//
//  DeleteAccountEmailRequest.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.11.2023.
//

import Foundation

struct DeleteAccountEmailRequest: Encodable {
    let to: String
    let subject: String
    let message: String
}
