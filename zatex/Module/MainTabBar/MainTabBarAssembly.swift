//
//  MainTabBarMainTabBarAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

class MainTabBarAssembly {
    
    static func create(
        with router: MainTabBarRouter
    ) -> UIViewController {
        
        let presenter = MainTabBarPresenter()
        let interactor = MainTabBarInteractor()
        
        let sessionProvider = AppSessionProvider()
        
        let viewController = MainTabBarViewController(
            presenter: presenter,
            sessionProvider: sessionProvider
        )
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
}
