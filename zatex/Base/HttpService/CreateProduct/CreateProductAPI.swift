//
//  CreateProductAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 06.04.2023.
//

import Foundation

typealias CreateProductCategoriesClosure = ([CategoryResult]) -> (Void)
typealias CreateProductPostClosure = () -> (Void)

protocol CreateProductAPI {

    func fetchCategories(completion: @escaping CreateProductCategoriesClosure) -> Void
    func createProduct(product: ProductResponse, completion: @escaping CreateProductPostClosure) -> Void
}
