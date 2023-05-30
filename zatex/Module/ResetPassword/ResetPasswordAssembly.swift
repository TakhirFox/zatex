//
//  ResetPasswordResetPasswordAssembly.swift
//  zatex
//
//  Created by winzero on 30/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class ResetPasswordAssembly {
    static func create() -> UIViewController {
        let viewController = ResetPasswordViewController()
        let presenter = ResetPasswordPresenter()
        let interactor = ResetPasswordInteractor()
        let router = ResetPasswordRouter()
        let networkService = ResetPasswordService.shared
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.service = networkService
        
        router.viewController = viewController
        
        return viewController
    }
    
}
