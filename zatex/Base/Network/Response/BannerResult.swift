//
//  BannerResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 24.10.2022.
//

import Foundation

struct BannerResult: Decodable, Hashable {
    
    let id: Int
    let title: String
    let secondDesc: String
    let description: String
    let imageBanner: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case secondDesc = "shortDesc"
        case description
        case imageBanner = "image"
    }
}
