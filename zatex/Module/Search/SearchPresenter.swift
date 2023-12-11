//
//  SearchSearchPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 25/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol SearchPresenterProtocol: AnyObject {
    func getSearchData(text: String)
    func addFavorite(productId: Int)
    func removeFavorite(productId: Int)
    
    func goToDetail(id: Int)
    
    func setResultProducts(data: [ProductResult])
    func setFavoriteList(data: [FavoriteResponse])
    
    func setError(data: String)
    func setToastError(text: String)
}

class SearchPresenter: BasePresenter {
    
    weak var view: SearchViewControllerProtocol?
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?
    var productEntity: [ProductResult] = []
    var sessionProvider: SessionProvider!
}

extension SearchPresenter: SearchPresenterProtocol {
    
    // MARK: To Interactor
    func getSearchData(text: String) {
        interactor?.getSearchResult(searchText: text)
    }
    
    func addFavorite(productId: Int) {
        interactor?.addFavorite(productId: productId)
    }
    
    func removeFavorite(productId: Int) {
        interactor?.removeFavorite(productId: productId)
    }
    
    // MARK: To Router
    func goToDetail(id: Int) {
        router?.routeToDetail(id: id)
    }
    
    // MARK: To View
    func setResultProducts(data: [ProductResult]) {
        productEntity = data
        
        let isAuthorized = sessionProvider.isAuthorized
        interactor?.getFavoriteList(isAuthorized: isAuthorized)
    }
    
    func setFavoriteList(data: [FavoriteResponse]) {
        let favoriteEntity = data.convertToEntities()
        
        productEntity.enumerated().forEach { index, product in
            if let favoriteEntity = favoriteEntity.first(where: { $0.id == product.id }) {
                productEntity[index].isFavorite = true
            }
        }
        
        view?.setResultProducts(data: productEntity)
    }
    
    func setError(data: String) {
        view?.showError(data: data)
    }
    
    func setToastError(text: String) {
        view?.showToastError(text: text)
    }
}
