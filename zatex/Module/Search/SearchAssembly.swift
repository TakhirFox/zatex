//
//  SearchSearchAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 25/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

class SearchAssembly {
    
    static func create(searchText: String) -> UIViewController {
        let viewController = SearchViewController()
        let presenter = SearchPresenter()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let sessionProvider = AppSessionProvider()
        
        let networkService = SearchService.shared
        let favoriteNetworkService = FavoritesService.shared
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.sessionProvider = sessionProvider
        
        interactor.presenter = presenter
        interactor.service = networkService
        interactor.getSearchResult(searchText: searchText)
        interactor.favoriteService = favoriteNetworkService
        
        router.viewController = viewController
        
        return viewController
    }
}
