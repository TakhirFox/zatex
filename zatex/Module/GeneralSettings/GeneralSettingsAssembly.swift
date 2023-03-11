//
//  GeneralSettingsGeneralSettingsAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

class GeneralSettingsAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = GeneralSettingsViewController()
        let presenter = GeneralSettingsPresenter()
        let interactor = GeneralSettingsInteractor()
        let router = GeneralSettingsRouter()
        
        let userSettingsService = UserSettingsService.shared
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.userSettings = userSettingsService
        
        router.viewController = viewController
        
        return viewController
    }
    
}
