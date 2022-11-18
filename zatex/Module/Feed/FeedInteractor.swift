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

}

extension FeedInteractor: FeedInteractorProtocol {
    func getProducts(page: Int) {
        self.service.fetchProducts(page: page) { result in
            self.presenter?.setProducts(data: result)
        }
    }
    
    func getCategories() {
        self.service.fetchCategories { result in
            self.presenter?.setCategories(data: result)
        }
    }
    
    func getBanners() {
        self.service.fetchBanners { result in
            self.presenter?.setBanners(data: result)
        }
    }
    
    func getProductByCategory(id: String) {
        self.service.fetchProductByCategory(id: id) { result in
            self.presenter?.setProductFromCategory(data: result)
        }
    }
    
}
