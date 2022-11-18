//
//  ProductAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.10.2022.
//

import Foundation

typealias ProductsClosure = ([ProductResult]) -> (Void)
typealias CategoriesClosure = ([CategoryResult]) -> (Void)

protocol ProductAPI {
    func fetchProducts(completion: @escaping ProductsClosure) -> (Void)
    func fetchCategories(completion: @escaping CategoriesClosure) -> Void
}
