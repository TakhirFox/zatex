//
//  CreateProductAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 06.04.2023.
//

import Foundation

typealias CreateProductCategoriesClosure = (Result<[CategoryResult], NetworkError>) -> (Void)
typealias CreateProductCurrenciesClosure = (Result<[CurrencyResult], NetworkError>) -> (Void)
typealias CreateProductPostClosure = (Result<ProductResult, NetworkError>) -> (Void)

protocol CreateProductAPI {

    func fetchCategories(
        completion: @escaping CreateProductCategoriesClosure
    ) -> Void
    
    func fetchCurrencies(
        completion: @escaping CreateProductCurrenciesClosure
    ) -> Void
    
    func createProduct(
        product: ProductResponse,
        completion: @escaping CreateProductPostClosure
    ) -> Void
}
