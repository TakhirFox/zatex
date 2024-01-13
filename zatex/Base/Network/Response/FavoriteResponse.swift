//
//  FavoriteResponse.swift
//  zatex
//
//  Created by Zakirov Tahir on 02.12.2023.
//

import Foundation

struct FavoriteResponse: Decodable {
    
    struct OptionsProduct: Decodable, Hashable {
        let id: Int
        let name: String
        let visible, variation: Bool
        let options: [String]
    }
    
    let postID, productName, productPrice: String
    let productImage: String?
    let postDate: String
    let attributes: [OptionsProduct]?

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case productName = "product_name"
        case productPrice = "product_price"
        case productImage = "product_image"
        case postDate = "post_date"
        case attributes
    }
}

extension Array where Element == FavoriteResponse {
    
    func convertToEntities() -> [ProductResult] {
        self.map { response in
            let image = ProductResult.Image(
                id: 0,
                src: response.productImage
            )
            
            let attributes = response.attributes?.map({ item in
                ProductResult.OptionsProduct(
                    id: item.id,
                    name: item.name,
                    visible: item.visible,
                    variation: item.variation,
                    options: item.options
                )
            }) ?? []
            
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
                attributes: attributes,
                isSales: nil,
                isFavorite: true
            )
        }
    }
}
