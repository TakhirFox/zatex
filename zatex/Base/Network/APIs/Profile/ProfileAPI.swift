//
//  ProfileAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 18.03.2023.
//

import Foundation

typealias ProfileStoreInfoClosure = (Result<StoreInfoResult, NetworkError>) -> (Void)
typealias ProfileStoreProductClosure = (Result<[ProductResult], NetworkError>) -> (Void)
typealias ProfileSalesProductClosure = (Result<ProductResult, NetworkError>) -> (Void)

protocol ProfileAPI {
    
    func fetchStoreInfo(
        authorId: Int,
        completion: @escaping ProfileStoreInfoClosure
    ) -> (Void)
    
    func fetchStoreProducts(
        authorId: Int,
        completion: @escaping ProfileStoreProductClosure
    ) -> (Void)
    
    func setSalesProfuct(
        productId: Int,
        isSales: Bool,
        completion: @escaping ProfileSalesProductClosure
    ) -> (Void)
}
