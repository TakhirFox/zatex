//
//  FavoritesFavoritesInteractor.swift
//  zatex
//
//  Created by winzero on 27/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol FavoritesInteractorProtocol {
    
}

class FavoritesInteractor: BaseInteractor, FavoritesInteractorProtocol {
    weak var presenter: FavoritesPresenterProtocol?

}