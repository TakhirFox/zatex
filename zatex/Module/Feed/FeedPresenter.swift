//
//  FeedFeedPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol FeedPresenterProtocol: AnyObject {
    func getProducts(page: Int)
    func getCategories()
    func getBanners()
    func getProductByCategory(id: String)
    
    func goToSearchResult(text: String)
    func goToDetail(id: String)
    
    func setProducts(data: [ProductResult])
    func setCategories(data: [CategoryResult])
    func setBanners(data: [BannerResult])
    func setProductFromCategory(data: [ProductResult])
}

class FeedPresenter: BasePresenter {
    weak var view: FeedViewControllerProtocol?
    var interactor: FeedInteractorProtocol?
    var router: FeedRouterProtocol?
    
}

extension FeedPresenter: FeedPresenterProtocol {
    
    // MARK: To Interactor
    func getProducts(page: Int) {
        interactor?.getProducts(page: page)
    }
    
    func getCategories() {
        interactor?.getCategories()
    }
    
    func getBanners() {
        interactor?.getBanners()
    }
    
    func getProductByCategory(id: String) {
        interactor?.getProductByCategory(id: id)
    }
    
    
    // MARK: To Router
    func goToSearchResult(text: String) {
        router?.routeToSearchResult(text: text)
    }
    
    func goToDetail(id: String) {
        router?.routeToDetail(id: id)
    }
    
    
    // MARK: To View
    func setProducts(data: [ProductResult]) {
        view?.setProducts(data: data)
    }
    
    func setCategories(data: [CategoryResult]) {
        view?.setCategories(data: data)
    }
    
    func setBanners(data: [BannerResult]) {
        view?.setBanners(data: data)
    }
    
    func setProductFromCategory(data: [ProductResult]) {
        view?.setProductFromCategory(data: data)
    }
    
    
}
