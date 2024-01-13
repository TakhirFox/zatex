//
//  CurrencyResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 13.01.2024.
//

import Foundation

struct CurrencyResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
    }
    
    let id: String
    let name: String
    let symbol: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        if let symbolString = try container.decodeIfPresent(String.self, forKey: .symbol),
           let data = symbolString.data(using: .unicode) {
            symbol = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil).string
        } else {
            symbol = ""
        }
    }
}
