//
//  ProductDetailAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 12.03.2023.
//

import Foundation

typealias ProductDetailClosure = (Result<ProductResult, NetworkError>) -> (Void)
typealias StoreInfoClosure = (Result<StoreInfoResult, NetworkError>) -> (Void)
typealias CheckChatClosure = (Result<CheckChatResult, NetworkError>) -> (Void)
typealias CheckChatReviewClosure = (Result<CheckChatReviewResult, NetworkError>) -> (Void)
typealias ReviewClosure = (Result<(), NetworkError>) -> (Void)

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
        productAuthor: Int,
        productId: Int,
        completion: @escaping CheckChatClosure
    ) -> (Void)
    
    func fetchCheckChatToReview(
        productAuthor: Int,
        productId: Int,
        completion: @escaping CheckChatReviewClosure
    ) -> (Void)
    
    func sendReview(
        id: Int,
        review: ReviewEntity,
        completion: @escaping ReviewClosure
    ) -> (Void)
}
