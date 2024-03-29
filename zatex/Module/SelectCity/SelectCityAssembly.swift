//
//  SelectCitySelectCityAssembly.swift
//  zatex
//
//  Created by winzero on 05/12/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class SelectCityAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = SelectCityViewController()
        let presenter = SelectCityPresenter()
        let interactor = SelectCityInteractor()
        let router = SelectCityRouter()
        let networkService = SelectCityService.shared
        
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
