//
//  ProfileEditProfileEditAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

class ProfileEditAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = ProfileEditViewController()
        let presenter = ProfileEditPresenter()
        let interactor = ProfileEditInteractor()
        let router = ProfileEditRouter()
        
        let networkService = ProfileEditService.shared
        let sessionProvider = AppSessionProvider()
        
        viewController.presenter = presenter
        viewController.sessionProvider = sessionProvider
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.service = networkService
        
        router.viewController = viewController
        
        return viewController
    }
    
}
