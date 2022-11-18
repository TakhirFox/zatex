//
//  ProductResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 30.10.2022.
//

import Foundation

// MARK: - ProductResult
struct ProductResult: Decodable, Hashable {
    let id: Int?
    let name, dateModified, status, catalogVisibility: String?
    let price, regularPrice, salePrice: String?
    let onSale: Bool?
    let images: [Image]?
    let store: Store?

    enum CodingKeys: String, CodingKey {
        case id, name
        case dateModified = "date_modified"
        case status
        case catalogVisibility = "catalog_visibility"
        case price
        case regularPrice = "regular_price"
        case salePrice = "sale_price"
        case onSale = "on_sale"
        case images, store
    }
}

extension ProductResult {
    // MARK: - Image
    struct Image: Codable, Hashable {
        let id: Int?
        let dateCreated, dateCreatedGmt, dateModified, dateModifiedGmt: String?
        let src: String?
        let name, alt: String?
        let position: Int?

        enum CodingKeys: String, CodingKey {
            case id
            case dateCreated = "date_created"
            case dateCreatedGmt = "date_created_gmt"
            case dateModified = "date_modified"
            case dateModifiedGmt = "date_modified_gmt"
            case src, name, alt, position
        }
    }

    // MARK: - Store
    struct Store: Codable, Hashable {
        let id: Int?
        let name, shopName: String?
        let url: String?
        let address: Address?

        enum CodingKeys: String, CodingKey {
            case id, name
            case shopName = "shop_name"
            case url, address
        }
    }

    // MARK: - Address
    struct Address: Codable, Hashable {
        let street1, street2, city, zip: String?
        let country, state: String?

        enum CodingKeys: String, CodingKey {
            case street1 = "street_1"
            case street2 = "street_2"
            case city, zip, country, state
        }
    }

}
