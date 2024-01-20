//
//  ProductResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 30.10.2022.
//

import Foundation

struct ProductResult: Decodable, Hashable {
    
    enum SaleStatus: String, Decodable {
        case publish = "publish"
        case draft = "draft"
        case none
    }
    
    let id: Int?
    let name: String?
    let dateModified: String?
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
    let attributes: [OptionsProduct]
    
    let saleStatus: SaleStatus?
    var isFavorite: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case dateModified = "date_modified"
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
        case attributes
        case saleStatus = "status"
        case isFavorite
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
        let address: ProductResult.AddressUnion?
        
        enum CodingKeys: String, CodingKey {
            case id, name
            case shopName = "shop_name"
            case address
        }
    }
    
    enum AddressUnion: Decodable, Hashable {
        
        case address(ProductResult.Address)
        case empty([String])
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode([String].self) {
                self = .empty(x)
                return
            }
            if let x = try? container.decode(ProductResult.Address.self) {
                self = .address(x)
                return
            }
            throw DecodingError.typeMismatch(AddressUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AddressUnion"))
        }
    }
    
    struct Address: Decodable, Hashable {
        let street1: String?
        let city: String?
        let country: String?

        enum CodingKeys: String, CodingKey {
            case street1 = "street_1"
            case city
            case country
        }
    }
    
    struct OptionsProduct: Decodable, Hashable {
        let id: Int
        let name: String
        let visible, variation: Bool
        let options: [String]
    }
}
