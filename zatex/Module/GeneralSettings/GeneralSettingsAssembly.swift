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
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
}