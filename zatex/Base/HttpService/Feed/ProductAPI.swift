//
//  ProductAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.10.2022.
//

import Foundation

typealias ProductsClosure = ([ProductResult]) -> (Void)
typealias CategoriesClosure = ([CategoryResult]) -> (Void)
typealias BannersClosure = ([BannerResult]) -> (Void)
typealias ProdByCategoryClosure = ([ProductResult]) -> (Void)

protocol ProductAPI {
    func fetchProducts(page: Int,
                       completion: @escaping ProductsClosure) -> (Void)
    
    func fetchCategories(completion: @escaping CategoriesClosure) -> Void
    
    func fetchBanners(completion: @escaping BannersClosure)
    
    func fetchProductByCategory(id: String,
                                completion: @escaping ProdByCategoryClosure)
}
