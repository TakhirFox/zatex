//
//  DeepLinkType.swift
//  zatex
//
//  Created by Zakirov Tahir on 10.08.2023.
//

import Foundation

enum DeepLinkType {
    case product(id: Int)
    case profile(id: Int)
    case chat(id: String)
}
