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
typealias ProfileUpdateDeviceTokenProductClosure = (Result<(), NetworkError>) -> (Void)

protocol ProfileAPI {
    
    func fetchStoreInfo(
        authorId: Int,
        completion: @escaping ProfileStoreInfoClosure
    ) -> (Void)
    
    func fetchStoreProducts(
        authorId: Int,
        currentPage: Int,
        saleStatus: String,
        completion: @escaping ProfileStoreProductClosure
    ) -> (Void)
    
    func fetchStoreStatsProducts(
        authorId: Int,
        completion: @escaping ProfileStoreProductClosure
    ) -> (Void)
    
    func setSalesProfuct(
        productId: Int,
        saleStatus: String,
        completion: @escaping ProfileSalesProductClosure
    ) -> (Void)
    
    func saveDeviceToken(
        authorId: Int,
        deviceToken: String,
        completion: @escaping ProfileUpdateDeviceTokenProductClosure
    ) -> (Void)
}
