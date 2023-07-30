//
//  SignUpSignUpAssembly.swift
//  zatex
//
//  Created by winzero on 28/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class SignUpAssembly {
    
    static func create(closeViewHandler: @escaping (() -> Void)) -> UIViewController {
        let viewController = SignUpViewController()
        let presenter = SignUpPresenter()
        let interactor = SignUpInteractor()
        let router = SignUpRouter()
        
        let networkService = SignUpService.shared
        let sessionProvider = AppSessionProvider()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.closeViewHandler = closeViewHandler
        
        interactor.presenter = presenter
        interactor.service = networkService
        interactor.sessionProvider = sessionProvider
        
        router.viewController = viewController
        
        return viewController
    }
    
}
