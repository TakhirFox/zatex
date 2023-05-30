//
//  CategoryResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.10.2022.
//

import Foundation

// MARK: - CategoryResult
struct CategoryResult: Decodable, Hashable {
    let id, count: Int?
    let name: String?
    var selected: Bool? = false
    
}
