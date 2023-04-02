//
//  ProductDetailAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 12.03.2023.
//

import Foundation

typealias ProductDetailClosure = (ProductResult) -> (Void)
typealias StoreInfoClosure = (StoreInfoResult) -> (Void)
typealias CheckChatClosure = (CheckChatResult) -> (Void)

protocol ProductDetailAPI {
    
    func fetchProductInfo(
        productId: Int,
        completion: @escaping ProductDetailClosure
    ) -> (Void)
    
    func fetchStoreInfo(
        authorId: Int,
        completion: @escaping StoreInfoClosure
    ) -> (Void)
    
    func fetchCheckChat(
        productAuthor: String,
        productId: String,
        completion: @escaping CheckChatClosure
    ) -> (Void)
}
