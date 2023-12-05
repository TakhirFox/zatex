//
//  ProductAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.10.2022.
//

import Foundation

typealias ProductsClosure = (Result<[ProductResult], NetworkError>) -> (Void)
typealias CategoriesClosure = (Result<[CategoryResult], NetworkError>) -> (Void)
typealias ProdByCategoryClosure = (Result<[ProductResult], NetworkError>) -> (Void)

protocol ProductAPI {
    
    func fetchProducts(
        page: Int,
        city: String,
        completion: @escaping ProductsClosure
    ) -> (Void)
    
    func fetchCategories(
        completion: @escaping CategoriesClosure
    ) -> Void
        
    func fetchProductByCategory(
        id: String,
        completion: @escaping ProdByCategoryClosure
    )
}
