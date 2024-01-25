//
//  ProductResponse.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.04.2023.
//

import Foundation

struct ProductResponse: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case name, description
        case regularPrice = "regular_price"
        case categories, images
        case attributes
    }
    
    struct Category: Encodable {
        let id: Int?
    }

    struct Image: Encodable {
        var src: String?
        var position: Int?
    }
    
    struct ProductOptions: Encodable {
        let name: String?
        let options: [String]?
        let visible: Bool?
        let variation: Bool?
    }
    
    let name: String?
    let description: String?
    let regularPrice: String?
    let categories: [ProductResponse.Category]?
    let images: [ProductResponse.Image]?
    let attributes: [ProductOptions]?
}

