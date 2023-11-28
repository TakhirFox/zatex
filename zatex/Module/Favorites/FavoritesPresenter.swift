//
//  FavoritesFavoritesPresenter.swift
//  zatex
//
//  Created by winzero on 27/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol FavoritesPresenterProtocol: AnyObject {

}

class FavoritesPresenter: BasePresenter {
    weak var view: FavoritesViewControllerProtocol?
    var interactor: FavoritesInteractorProtocol?
    var router: FavoritesRouterProtocol?
    
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    
}
