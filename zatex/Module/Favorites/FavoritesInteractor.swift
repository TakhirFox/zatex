//
//  FavoritesFavoritesInteractor.swift
//  zatex
//
//  Created by winzero on 27/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol FavoritesInteractorProtocol {
    
    func getFavoriteList(userId: Int)
    func addFavorite()
    func removeFavorite()
}

class FavoritesInteractor: BaseInteractor {
    
    weak var presenter: FavoritesPresenterProtocol?
    var service: FavoritesAPI!
}

extension FavoritesInteractor: FavoritesInteractorProtocol {
    
    func getFavoriteList(userId: Int) {
        self.service.fetchFavoriteList(userId: userId) { result in
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
    
    func addFavorite() {
        self.service.addFavorite() { result in
            switch result {
            case let .success(data):
//                self.presenter?.setFavoriteList(data: data)
                break
                
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
    
    func removeFavorite() {
        self.service.removeFavorite() { result in
            switch result {
            case let .success(data):
//                self.presenter?.setFavoriteList(data: data)
                break
                
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
}
