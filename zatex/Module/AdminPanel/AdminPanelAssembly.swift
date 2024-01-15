//
//  AdminPanelAdminPanelAssembly.swift
//  zatex
//
//  Created by winzero on 14/01/2024.
//  Copyright © 2024 zakirovweb. All rights reserved.
//

import UIKit

class AdminPanelAssembly {
    
    static func create(type: AdminPanelPresenter.AdminPanelType) -> UIViewController {
        let viewController = AdminPanelViewController()
        let presenter = AdminPanelPresenter()
        let interactor = AdminPanelInteractor()
        let router = AdminPanelRouter()
        let networkService = AdminPanelService.shared
        
        viewController.presenter = presenter
        viewController.adminPanelType = type
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.service = networkService
        
        router.viewController = viewController
        
        return viewController
    }
    
}
