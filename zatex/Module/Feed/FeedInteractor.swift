//
//  FeedFeedInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol FeedInteractorProtocol {
    
    func getProducts(
        categoryId: Int?,
        page: Int,
        city: String
    )
    
    func getCategories()
    func getBanners()
    
    func getFavoriteList(isAuthorized: Bool)
    func addFavorite(productId: Int)
    func removeFavorite(productId: Int)
}

class FeedInteractor: BaseInteractor {
    
    weak var presenter: FeedPresenterProtocol?
    var service: ProductAPI!
    var newsService: NewsAPI!
    var favoriteService: FavoritesAPI!
}

extension FeedInteractor: FeedInteractorProtocol {
    
    func getProducts(
        categoryId: Int?,
        page: Int,
        city: String
    ) {
        self.service.fetchProducts(
            categoryId: categoryId,
            page: page,
            city: city
        ) { result in
            switch result {
            case let .success(data):
                self.presenter?.setProducts(data: data)
                
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
    
    func getCategories() {
        self.service.fetchCategories { result in
            switch result {
            case let .success(data):
                self.presenter?.setCategories(data: data)
                
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

extension FeedInteractor {
    
    func getBanners() {
        self.newsService.fetchNewsList { result in
            switch result {
            case let .success(data):
                self.presenter?.setBanners(data: data)
                
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

extension FeedInteractor {
    
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
