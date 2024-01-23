//
//  EditProductAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.01.2024.
//

import Foundation

typealias ProductClosure = (Result<ProductResult, NetworkError>) -> (Void)
typealias UpdateProductClosure = (Result<(), NetworkError>) -> (Void)

protocol EditProductAPI {
    
    func fetchProductInfo(
        id: Int,
        completion: @escaping ProductClosure
    ) -> Void
    
    func updateProductInfo(
        id: Int,
        product: ProductResponse,
        completion: @escaping UpdateProductClosure
    ) -> Void
}
