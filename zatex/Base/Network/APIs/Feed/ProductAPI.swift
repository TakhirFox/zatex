//
//  ProductAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.10.2022.
//

import Foundation

typealias ProductsClosure = (Result<[ProductResult], NetworkError>) -> (Void)
typealias CategoriesClosure = (Result<[CategoryResult], NetworkError>) -> (Void)

protocol ProductAPI {
    
    func fetchProducts(
        categoryId: Int?,
        page: Int,
        city: String,
        completion: @escaping ProductsClosure
    ) -> (Void)
    
    func fetchCategories(
        completion: @escaping CategoriesClosure
    ) -> Void
}
