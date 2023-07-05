//
//  ProfileEditRequest.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.07.2023.
//

import Foundation

struct ProfileEditRequest: Encodable {
    let title: String
    let content: String?
    let rating: Int
}
