//
//  FeedFeedPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import Foundation

protocol FeedPresenterProtocol: AnyObject {
    
    func getProducts(
        categoryId: Int?,
        page: Int
    )
    
    func getCategories()
    func getBanners()
    
    func addFavorite(productId: Int)
    func removeFavorite(productId: Int)
    
    
    func goToSearchResult(text: String)
    func goToDetail(id: Int)
    func goToNews(entity: BannerResult)
    func goToChangeCity()
    
    
    func setProducts(data: [ProductResult])
    func setCategories(data: [CategoryResult])
    func setBanners(data: [BannerResult])
    func setFavoriteList(data: [FavoriteResponse])
    
    func setError(data: String)
    func setToastError(text: String)
}

class FeedPresenter: BasePresenter {
    
    weak var view: FeedViewControllerProtocol?
    var interactor: FeedInteractorProtocol?
    var router: FeedRouterProtocol?
    var productEntity: [ProductResult] = []
    var sessionProvider: SessionProvider!
}

extension FeedPresenter: FeedPresenterProtocol {
    
    // MARK: To Interactor
    func getProducts(
        categoryId: Int?,
        page: Int
    ) {
        let city = UserDefaults.standard.string(forKey: "MyCity") ?? ""
        
        interactor?.getProducts(
            categoryId: categoryId,
            page: page,
            city: city
        )
    }
    
    func getCategories() {
        interactor?.getCategories()
    }
    
    func getBanners() {
        interactor?.getBanners()
    }
    
    func addFavorite(productId: Int) {
        interactor?.addFavorite(productId: productId)
    }
    
    func removeFavorite(productId: Int) {
        interactor?.removeFavorite(productId: productId)
    }
    
    
    // MARK: To Router
    func goToSearchResult(text: String) {
        router?.routeToSearchResult(text: text)
    }
    
    func goToDetail(id: Int) {
        router?.routeToDetail(id: id)
    }
    
    func goToNews(entity: BannerResult) {
        router?.routeToNews(entity: entity)
    }
    
    func goToChangeCity() {
        router?.goToChangeCity()
    }
    
    
    // MARK: To View
    func setProducts(data: [ProductResult]) {
        productEntity = data
        
        let isAuthorized = sessionProvider.isAuthorized
        interactor?.getFavoriteList(isAuthorized: isAuthorized)
    }
    
    func setCategories(data: [CategoryResult]) {
        view?.setCategories(data: data)
    }
    
    func setBanners(data: [BannerResult]) {
        view?.setBanners(data: data)
    }
    
    func setFavoriteList(data: [FavoriteResponse]) {
        let favoriteEntity = data.convertToEntities()
        
        productEntity.enumerated().forEach { index, product in
            if let favoriteEntity = favoriteEntity.first(where: { $0.id == product.id }) {
                productEntity[index].isFavorite = true
            }
        }
        
        view?.setProducts(data: productEntity)
    }
    
    func setError(data: String) {
        view?.showError(data: data)
    }
    
    func setToastError(text: String) {
        view?.showToastError(text: text)
    }
}
