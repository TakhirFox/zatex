//
//  AuthAuthAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 08/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class AuthAssembly {
    static func create(authorizationHandler: @escaping (() -> Void)) -> UIViewController {
        let viewController = AuthViewController()
        let presenter = AuthPresenter()
        let interactor = AuthInteractor()
        let router = AuthRouter()
        
        let networkService = AuthService.shared
        let sessionProvider = AppSessionProvider()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.authorizationHandler = authorizationHandler
        
        interactor.presenter = presenter
        interactor.service = networkService
        interactor.sessionProvider = sessionProvider
        
        router.viewController = viewController
        
        return viewController
    }
    
}
