//
//  ProductDetailService.swift
//  zatex
//
//  Created by Zakirov Tahir on 12.03.2023.
//

import Alamofire

class ProductDetailService {
    private lazy var httpService = ProductDetailHttpService()
    static let shared: ProductDetailService = ProductDetailService()
}

extension ProductDetailService: ProductDetailAPI {
    func fetchProductInfo(
        productId: Int,
        completion: @escaping ProductDetailClosure
    ) {
        do {
            try ProductDetailHttpRouter
                .getProductInfo(productId: productId)
                .request(usingHttpService: httpService)
                .cURLDescription { description in
                    print("LOG: getProductInfo \(description)")
                }
                .responseDecodable(of: ProductResult.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 0998909099230092 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 0027637771677716 Ошибка получения информации о товаре")))
        }
    }
    
    func fetchStoreInfo(
        authorId: Int,
        completion: @escaping StoreInfoClosure
    ) {
        do {
            try ProductDetailHttpRouter
                .getStoreInfo(authorId: authorId)
                .request(usingHttpService: httpService)
                .responseDecodable(of: StoreInfoResult.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 23777454545232 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 557916778716 Ошибка получения информации о магазине")))
        }
    }
    
    func fetchCheckChat(
        productAuthor: Int,
        productId: Int,
        completion: @escaping CheckChatClosure
    ) {
        do {
            try ProductDetailHttpRouter
                .checkChat(
                    productAuthor: productAuthor,
                    productId: productId)
                .request(usingHttpService: httpService)
                .responseDecodable(of: CheckChatResult.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 0998666230092 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 9952737243 Ошибка проверки чата")))
        }
    }
    
    func fetchCheckChatToReview(
        productAuthor: Int,
        productId: Int,
        completion: @escaping CheckChatReviewClosure
    ) {
        do {
            try ProductDetailHttpRouter
                .checkChatToReview(
                    productAuthor: productAuthor,
                    productId: productId)
                .request(usingHttpService: httpService)
                .cURLDescription { description in
                    print("LOG: checkChatToReview \(description)")
                }
                .responseDecodable(of: CheckChatReviewResult.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 734556474568 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 53464574658458 Ошибка проверки чата для ревью")))
        }
    }
    
    func sendReview(
        id: Int,
        review: ReviewEntity,
        completion: @escaping ReviewClosure
    ) {
        do {
            try ProductDetailHttpRouter
                .sendReview(id: id, review: review)
                .request(usingHttpService: httpService)
                .cURLDescription { description in
                    print("LOG: sendReview \(description)")
                }
                .response { response in
                    switch response.result {
                    case .success:
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 239784892734 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 25230895 Ошибка отправки отзыва")))
        }
    }
}
