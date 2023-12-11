//
//  FavoritesFavoritesInteractor.swift
//  zatex
//
//  Created by winzero on 27/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol FavoritesInteractorProtocol {
    
    func getFavoriteList(isAuthorized: Bool)
    func addFavorite(productId: Int)
    func removeFavorite(productId: Int)
}

class FavoritesInteractor: BaseInteractor {
    
    weak var presenter: FavoritesPresenterProtocol?
    var service: FavoritesAPI!
}

extension FavoritesInteractor: FavoritesInteractorProtocol {
    
    func getFavoriteList(isAuthorized: Bool) {
        self.service.fetchFavoriteList(isAuthorized: isAuthorized) { result in
            switch result {
            case let .success(data):
                self.presenter?.setFavoriteList(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setError(data: name)
                    
                case let .secondError(name):
                    self.presenter?.setError(data: name)
                }
            }
        }
    }
    
    func addFavorite(productId: Int) {
        self.service.addFavorite(productId: productId) { result in
            switch result {
            case .success:
                break
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastAddError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setToastAddError(text: name)
                }
            }
        }
    }
    
    func removeFavorite(productId: Int) {
        self.service.removeFavorite(productId: productId) { result in
            switch result {
            case .success:
                break
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastRemoveError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setToastRemoveError(text: name)
                }
            }
        }
    }
}
