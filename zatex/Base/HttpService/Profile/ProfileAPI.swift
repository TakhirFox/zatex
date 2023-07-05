//
//  ProfileAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 18.03.2023.
//

import Foundation

typealias ProfileStoreInfoClosure = (StoreInfoResult) -> (Void)
typealias ProfileStoreProductClosure = ([ProductResult]) -> (Void)

protocol ProfileAPI {
    
    func fetchStoreInfo(
        authorId: Int,
        completion: @escaping ProfileStoreInfoClosure
    ) -> (Void)
    
    func fetchStoreProducts(
        authorId: Int,
        completion: @escaping ProfileStoreProductClosure
    ) -> (Void)
}
