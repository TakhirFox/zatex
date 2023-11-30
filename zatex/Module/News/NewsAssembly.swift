//
//  NewsNewsAssembly.swift
//  zatex
//
//  Created by winzero on 29/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class NewsAssembly {
    static func create(newsEntity: BannerResult) -> UIViewController {
        let viewController = NewsViewController()
        let presenter = NewsPresenter()
        let interactor = NewsInteractor()
        let router = NewsRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.newsEntity = newsEntity
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
}
