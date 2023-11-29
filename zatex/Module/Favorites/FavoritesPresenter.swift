//
//  FavoritesFavoritesPresenter.swift
//  zatex
//
//  Created by winzero on 27/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol FavoritesPresenterProtocol: AnyObject {
    func getFavoriteList(userId: Int)
    func addFavorite()
    func removeFavorite()
    
    func goToDetail(id: Int)
    
    func setFavoriteList(data: [ProductResult])
    func setError(data: String)
    func setToastError(text: String)
}

class FavoritesPresenter: BasePresenter {
    weak var view: FavoritesViewControllerProtocol?
    var interactor: FavoritesInteractorProtocol?
    var router: FavoritesRouterProtocol?
    
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    
    // MARK: To Interactor
    func getFavoriteList(userId: Int) {
        interactor?.getFavoriteList(userId: userId)
    }
    
    func addFavorite() {
        interactor?.addFavorite()
    }
    
    func removeFavorite() {
        interactor?.removeFavorite()
    }
    
    // MARK: To Router
    func goToDetail(id: Int) {
        router?.routeToDetail(id: id)
    }
    
    // MARK: To View
    func setFavoriteList(data: [ProductResult]) {
        view?.setFavoriteList(data: data)
    }
    
    func setError(data: String) {
        view?.showError(data: data)
    }
    
    func setToastError(text: String) {
        view?.showToastError(text: text)
    }
}
