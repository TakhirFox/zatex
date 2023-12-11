//
//  FavoritesFavoritesPresenter.swift
//  zatex
//
//  Created by winzero on 27/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol FavoritesPresenterProtocol: AnyObject {
    
    func getFavoriteList()
    func addFavorite(productId: Int)
    func removeFavorite(productId: Int)
    
    func goToDetail(id: Int)
    
    func setFavoriteList(data: [FavoriteResponse])
    func setError(data: String)
    func setToastAddError(text: String)
    func setToastRemoveError(text: String)
}

class FavoritesPresenter: BasePresenter {
    
    weak var view: FavoritesViewControllerProtocol?
    var interactor: FavoritesInteractorProtocol?
    var router: FavoritesRouterProtocol?
    var sessionProvider: SessionProvider!
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    
    // MARK: To Interactor
    func getFavoriteList() {
        let isAuthorized = sessionProvider.isAuthorized
        interactor?.getFavoriteList(isAuthorized: isAuthorized)
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
    func setFavoriteList(data: [FavoriteResponse]) {
        let entity = data.convertToEntities()
        
        view?.setFavoriteList(data: entity)
    }
    
    func setError(data: String) {
        view?.showError(data: data)
    }
    
    func setToastAddError(text: String) {
        view?.showToastAddError(text: text)
    }
    
    func setToastRemoveError(text: String) {
        view?.showToastRemoveError(text: text)
    }
}
