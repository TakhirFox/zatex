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
                .cURLDescription { description in
                    print("LOG: getReviewsList \(description)")
                }
                .responseDecodable(of: [ReviewsListResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                        guard !data.isEmpty else { return }
                    case .failure(let error):
                        if response.response?.statusCode == 404 {
                            completion(.failure(.error(name: "Пустой")))
                        } else {
                            completion(.failure(.error(name: "Ошибка: 23543698238 - \(error)")))
                        }
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 004988342 Ошибка списка отзывов")))
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
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 3456796934 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 9908768546456 Ошибка получения инфы о магазине в отзывах")))
        }
    }
}
