//
//  ProductResponse.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.04.2023.
//

import Foundation

struct ProductResponse: Encodable {
    
    struct Category: Encodable {
        let id: Int?
    }

    struct Image: Encodable {
        let src: String?
        let position: Int?
    }
    
    let name, description, regularPrice: String?
    let categories: [ProductResponse.Category]?
    let images: [ProductResponse.Image]?

    enum CodingKeys: String, CodingKey {
        case name, description
        case regularPrice = "regular_price"
        case categories, images
    }
}

