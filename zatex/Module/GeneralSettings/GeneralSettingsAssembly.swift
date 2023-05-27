//
//  GeneralSettingsGeneralSettingsAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

class GeneralSettingsAssembly {
    static func create(logoutHandler: @escaping (() -> Void)) -> UIViewController {
        let viewController = GeneralSettingsViewController()
        let presenter = GeneralSettingsPresenter()
        let interactor = GeneralSettingsInteractor()
        let router = GeneralSettingsRouter()
        
        let sessionProvider = AppSessionProvider()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.logoutHandler = logoutHandler
        
        interactor.presenter = presenter
        interactor.sessionProvider = sessionProvider
        
        router.viewController = viewController
        
        return viewController
    }
    
}
