//
//  FavoritesFavoritesAssembly.swift
//  zatex
//
//  Created by winzero on 27/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class FavoritesAssembly: BaseAssemblyProtocol {
    
    static func create() -> UIViewController {
        let viewController = FavoritesViewController()
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        let networkService = FavoritesService.shared
        let sessionProvider = AppSessionProvider()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.sessionProvider = sessionProvider
        
        interactor.presenter = presenter
        interactor.service = networkService
        
        router.viewController = viewController
        
        return viewController
    }
}
