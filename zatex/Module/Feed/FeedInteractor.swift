//
//  FeedFeedInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol FeedInteractorProtocol {
    
    func getProducts(page: Int)
    func getCategories()
    func getBanners()
    func getProductByCategory(id: String)
}

class FeedInteractor: BaseInteractor {
    
    weak var presenter: FeedPresenterProtocol?
    var service: ProductAPI!
    var newsService: NewsAPI!
}

extension FeedInteractor: FeedInteractorProtocol {
    
    func getProducts(page: Int) {
        self.service.fetchProducts(page: page) { result in
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
    
    func getProductByCategory(id: String) {
        self.service.fetchProductByCategory(id: id) { result in
            switch result {
            case let .success(data):
                self.presenter?.setProductFromCategory(data: data)
                
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
