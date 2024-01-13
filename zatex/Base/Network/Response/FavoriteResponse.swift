//
//  FavoriteResponse.swift
//  zatex
//
//  Created by Zakirov Tahir on 02.12.2023.
//

import Foundation

struct FavoriteResponse: Decodable {
    
    let postID, productName, productPrice: String
    let productImage: String?
    let postDate: String

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case productName = "product_name"
        case productPrice = "product_price"
        case productImage = "product_image"
        case postDate = "post_date"
    }
}

extension Array where Element == FavoriteResponse {
    
    func convertToEntities() -> [ProductResult] {
        self.map { response in
            let image = ProductResult.Image(
                id: 0,
                src: response.productImage
            )
            
            return ProductResult(
                id: Int(response.postID),
                name: response.productName,
                dateModified: response.postDate,
                status: nil,
                description: nil,
                price: response.productPrice,
                regularPrice: nil,
                onSale: nil,
                reviewsAllowed: nil,
                averageRating: nil,
                ratingCount: nil,
                categories: nil,
                images: [image],
                store: nil,
                relatedIDS: nil,
                attributes: [],
                isSales: nil,
                isFavorite: true
            )
        }
    }
}
