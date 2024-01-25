//
//  ProductEntity.swift
//  zatex
//
//  Created by Zakirov Tahir on 06.04.2023.
//

import UIKit

struct ProductEntity {
    
    struct Image {
        var image: UIImage
    }
    
    var productName: String?
    var category: Int?
    var categoryName: String?
    var description: String?
    var cost: String?
    var currencySymbol: String?
    var images: [ProductEntity.Image] = []
    var webImages: [String]?
}
