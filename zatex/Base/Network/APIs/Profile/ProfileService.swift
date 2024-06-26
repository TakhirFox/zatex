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
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 237777894567 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 5577777016 Ошибка получения информации о магазине в профиле")))
        }
    }
    
    func fetchStoreProducts(
        authorId: Int,
        currentPage: Int,
        saleStatus: String,
        completion: @escaping ProfileStoreProductClosure
    ) {
        do {
            try ProfileHttpRouter
                .getStoreProducts(
                    authorId: authorId,
                    currentPage: currentPage,
                    saleStatus: saleStatus
                )
                .request(usingHttpService: httpService)
                .responseDecodable(of: [ProductResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 2379450909967 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 45678886764568: Ошибка получения товаров в профиле")))
        }
    }
    
    func fetchStoreStatsProducts(
        authorId: Int,
        completion: @escaping ProfileStoreProductClosure
    ) {
        do {
            try ProfileHttpRouter
                .getStoreStatsProducts(authorId: authorId)
                .request(usingHttpService: httpService)
                .responseDecodable(of: [ProductResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 45634563456 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 75646574567: Ошибка получения статистики в профиле")))
        }
    }
    
    func setSalesProfuct(
        productId: Int,
        saleStatus: String,
        completion: @escaping ProfileSalesProductClosure
    ) {
        do {
            try ProfileHttpRouter
                .updateSalesProduct(
                    productId: productId,
                    saleStatus: saleStatus
                )
                .request(usingHttpService: httpService)
                .cURLDescription { description in
                    print("LOG: updateSalesProduct \(description)")
                }
                .responseDecodable(of: ProductResult.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 3458388345890 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 980348589: Ошибка установка статуса товара в профиле")))
        }
    }
    
    func saveDeviceToken(
        authorId: Int,
        deviceToken: String,
        completion: @escaping ProfileUpdateDeviceTokenProductClosure
    ) {
        do {
            try ProfileHttpRouter
                .updateDeviceTokek(
                    authorId: authorId,
                    deviceToken: deviceToken
                )
                .request(usingHttpService: httpService)
                .cURLDescription { description in
                    print("LOG: updateDeviceTokek \(description)")
                }
                .responseDecodable(of: ProductResult.self) { response in
                    switch response.result {
                    case .success:
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 568745646854568 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 345345345: Ошибка установки девайс токена в профиле")))
        }
    }
}
