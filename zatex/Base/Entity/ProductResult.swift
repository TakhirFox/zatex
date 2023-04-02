//
//  ProductResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 30.10.2022.
//

import Foundation

struct ProductResult: Decodable, Hashable {
    let id: Int?
    let name: String?
    let dateModified: String?
    let status: String?
    let description: String?
    let price, regularPrice: String?
    let onSale: Bool?
    let reviewsAllowed: Bool?
    let averageRating: String?
    let ratingCount: Int?
    let categories: [ProductResult.Category]?
    let images: [ProductResult.Image]?
    let store: ProductResult.Store?
    let relatedIDS: [Int]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case dateModified = "date_modified"
        case status
        case description
        case price
        case regularPrice = "regular_price"
        case onSale = "on_sale"
        case reviewsAllowed = "reviews_allowed"
        case averageRating = "average_rating"
        case ratingCount = "rating_count"
        case categories, images
        case store
        case relatedIDS = "related_ids"
    }
    
    struct Category: Decodable, Hashable {
        let id: Int?
        let name: String?
    }

    struct Image: Decodable, Hashable {
        let id: Int?
        let src: String?

        enum CodingKeys: String, CodingKey {
            case id
            case src
        }
    }

    struct Store: Decodable, Hashable {
        let id: Int?
        let name: String?
        let shopName: String?
        let address: ProductResult.Address?

        enum CodingKeys: String, CodingKey {
            case id, name
            case shopName = "shop_name"
            case address
        }
    }
    
    struct Address: Decodable, Hashable {
        let street1, city: String?

        enum CodingKeys: String, CodingKey {
            case street1 = "street_1"
            case city
        }
    }
}
