//
//  ProfileProfileAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

class ProfileAssembly {
    
    static func create(onSignal: @escaping (ProfilePresenter.Signal) -> Void) -> UIViewController {
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
        presenter.onSignal = onSignal
        
        interactor.presenter = presenter
        interactor.service = networkService
        
        router.viewController = viewController
        
        return viewController
    }
}
