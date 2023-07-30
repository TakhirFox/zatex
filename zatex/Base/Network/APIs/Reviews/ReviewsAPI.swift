//
//  ReviewsAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 20.03.2023.
//

import Foundation

typealias ReviewsListClosure = (Result<[ReviewsListResult], NetworkError>) -> (Void)
typealias ReviewsStoreInfoClosure = (Result<StoreInfoResult, NetworkError>) -> (Void)

protocol ReviewsAPI  {
    
    func fetchReviews(
        authorId: String,
        completion: @escaping ReviewsListClosure
    ) -> Void
    
    func fetchStoreInfo(
        authorId: String,
        completion: @escaping ReviewsStoreInfoClosure
    ) -> Void
}
