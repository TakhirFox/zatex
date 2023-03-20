//
//  ProfileService.swift
//  zatex
//
//  Created by Zakirov Tahir on 18.03.2023.
//

import Alamofire

class ProfileService {
    private lazy var httpService = ProfileHttpService()
    static let shared: ProfileService = ProfileService()
}

extension ProfileService: ProfileAPI {

    func fetchStoreInfo(
        authorId: Int,
        completion: @escaping ProfileStoreInfoClosure
    ) {
        do {
            try ProfileHttpRouter
                .getStoreInfo(authorId: authorId)
                .request(usingHttpService: httpService)
                .responseDecodable(of: StoreInfoResult.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        print("LOG: 237777894567 Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG: 5577777016 Ошибка получения информации о магазине в профиле")
        }
    }
    
    func fetchStoreProducts(
        authorId: Int,
        completion: @escaping ProfileStoreProductClosure
    ) {
        do {
            try ProfileHttpRouter
                .getStoreProducts(authorId: authorId)
                .request(usingHttpService: httpService)
                .responseDecodable(of: [ProductResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        print("LOG: 2379450909967 Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG: 45678886764568: Ошибка получения товаров в профиле")
        }
    }
}
