//
//  AuthAuthAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 08/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class AuthAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = AuthViewController()
        let presenter = AuthPresenter()
        let interactor = AuthInteractor()
        let router = AuthRouter()
        
        let networkService = AuthService.shared
        let userSettingsService = UserSettingsService.shared
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.service = networkService
        interactor.userSettings = userSettingsService
        
        router.viewController = viewController
        
        return viewController
    }
    
}
