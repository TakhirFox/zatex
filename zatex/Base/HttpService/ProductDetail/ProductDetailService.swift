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
                .responseDecodable(of: ProductResult.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        print("LOG 0998909099230092: Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG 0027637771677716: Ошибка получения информации о товаре")
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
                        completion(data)
                    case .failure(let error):
                        print("LOG 23777454545232: Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG 557916778716: Ошибка получения информации о магазине")
        }
    }
    
    func fetchCheckChat(
        productAuthor: String,
        productId: String,
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
                        completion(data)
                    case .failure(let error):
                        print("LOG 0998666230092: Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG 9952737243: Ошибка проверки чата")
        }
    }
}
