//
//  FeedFeedAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

class FeedAssembly: BaseAssemblyProtocol {
    
    static func create() -> UIViewController {
        let viewController = FeedViewController()
        let presenter = FeedPresenter()
        let interactor = FeedInteractor()
        let router = FeedRouter()
        let sessionProvider = AppSessionProvider()
        
        let networkService = ProductService.shared
        let newsNetworkService = NewsService.shared
        let favoriteNetworkService = FavoritesService.shared
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.sessionProvider = sessionProvider
        
        interactor.presenter = presenter
        interactor.service = networkService
        interactor.newsService = newsNetworkService
        interactor.favoriteService = favoriteNetworkService
        
        router.viewController = viewController
        
        return viewController
    }
}
