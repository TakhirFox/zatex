//
//  MainTabBarMainTabBarAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

class MainTabBarAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let presenter = MainTabBarPresenter()
        let interactor = MainTabBarInteractor()
        let router = MainTabBarRouter()
        let viewController = MainTabBarViewController(presenter: presenter)
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
//        interactor.networkService = networkService
        
        router.viewController = viewController
        
        return viewController
    }
    
}
