//
//  SearchSearchInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 25/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol SearchInteractorProtocol {
    
    func getSearchResult(searchText: String)
    
    func getFavoriteList(isAuthorized: Bool)
    func addFavorite(productId: Int)
    func removeFavorite(productId: Int)
}

class SearchInteractor: BaseInteractor {
    
    weak var presenter: SearchPresenterProtocol?
    var service: SearchAPI!
    var favoriteService: FavoritesAPI!
    var searchText = ""
}

extension SearchInteractor: SearchInteractorProtocol {
    func getSearchResult(searchText: String) {
        self.service.fetchSearchResult(search: searchText) { result in
            switch result {
            case let .success(data):
                self.presenter?.setResultProducts(data: data)
                
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

extension SearchInteractor {
    func getFavoriteList(isAuthorized: Bool) {
        self.favoriteService.fetchFavoriteList(
            isAuthorized: isAuthorized,
            page: 1
        ) { result in
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
        self.favoriteService.addFavorite(productId: productId) { result in
            switch result {
            case .success:
                break
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setToastError(text: name)
                }
            }
        }
    }
    
    func removeFavorite(productId: Int) {
        self.favoriteService.removeFavorite(productId: productId) { result in
            switch result {
            case .success:
                break
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setToastError(text: name)
                }
            }
        }
    }
}
