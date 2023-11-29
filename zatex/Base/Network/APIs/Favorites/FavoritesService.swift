//
//  FavoritesService.swift
//  zatex
//
//  Created by Zakirov Tahir on 28.11.2023.
//

import Alamofire

class FavoritesService {
    private lazy var httpService = FavoritesHttpService()
    static let shared: FavoritesService = FavoritesService()
}

extension FavoritesService: FavoritesAPI {

    func fetchFavoriteList(
        userId: Int,
        completion: @escaping FavoriteListClosure
    ) {
        do {
            try FavoritesHttpRouter
                .getFavoriteList(userId: userId)
                .request(usingHttpService: httpService)
                .responseDecodable(of: [ProductResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 32462346 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 34573457 Ошибка получения списка любимых товаров")))
        }
    }
    
    func addFavorite(
        completion: @escaping SetFavoriteClosure
    ) {
        do {
            try FavoritesHttpRouter
                .addFavorite
                .request(usingHttpService: httpService)
                .response { response in
                    switch response.result {
                    case .success:
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 657867657 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 45674567456 Ошибка добавления в избранное")))
        }
    }
    
    func removeFavorite(
        completion: @escaping SetFavoriteClosure
    ) {
        do {
            try FavoritesHttpRouter
                .removeFavorite
                .request(usingHttpService: httpService)
                .response { response in
                    switch response.result {
                    case .success:
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 634563456 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 934658358 Ошибка удаления из избранное")))
        }
    }
}
