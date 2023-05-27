//
//  ProfileProfileAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

class ProfileAssembly {
    static func create(updateTabBarHandler: @escaping (() -> Void)) -> UIViewController {
        //TODO: Передавать лучше ID, или для других пользователей отдельный экран???
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        let router = ProfileRouter()
        
        let networkService = ProfileService.shared
        let sessionProvider = AppSessionProvider()
        
        viewController.presenter = presenter
        viewController.sessionProvider = sessionProvider
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.updateTabBarHandler = updateTabBarHandler
        
        interactor.presenter = presenter
        interactor.service = networkService
        
        router.viewController = viewController
        
        return viewController
    }
    
}
