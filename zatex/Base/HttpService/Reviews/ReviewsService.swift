//
//  ReviewsService.swift
//  zatex
//
//  Created by Zakirov Tahir on 20.03.2023.
//

import Alamofire

class ReviewsService {
    private lazy var httpService = ReviewsHttpService()
    static let shared: ReviewsService = ReviewsService()
}

extension ReviewsService: ReviewsAPI {
    func fetchReviews(
        authorId: String,
        completion: @escaping ReviewsListClosure
    ) {
        do {
            try ReviewsHttpRouter
                .getReviewsList(authorId: authorId)
                .request(usingHttpService: httpService)
                .responseDecodable(of: [ReviewsListResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                        guard !data.isEmpty else { return }
                    case .failure(let error):
                        print("LOG: 23543698238 Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG: 004988342 Ошибка списка отзывов")
        }
    }
    
    func fetchStoreInfo(
        authorId: String,
        completion: @escaping ReviewsStoreInfoClosure
    ) {
        do {
            try ReviewsHttpRouter
                .getStoreInfo(authorId: authorId)
                .request(usingHttpService: httpService)
                .responseDecodable(of: StoreInfoResult.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        print("LOG: 3456796934 Ошибка \(error)")
                    }
                }
        } catch {
            print("LOG: 9908768546456 Ошибка получения инфы о магазине в отзывах")
        }
    }
}
