//
//  CategoryResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.10.2022.
//

import Foundation

struct CategoryResult: Decodable, Hashable {
    
    let id, count: Int?
    let name: String?
    let description: String?
    var selected: Bool? = false
}
