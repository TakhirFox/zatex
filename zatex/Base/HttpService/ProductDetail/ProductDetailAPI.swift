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
typealias CheckChatReviewClosure = (CheckChatReviewResult) -> (Void)
typealias ReviewClosure = () -> (Void)

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
