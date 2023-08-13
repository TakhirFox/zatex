//
//  UserProfileUserProfileAssembly.swift
//  zatex
//
//  Created by winzero on 13/08/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class UserProfileAssembly {
    
    static func create(userId: Int) -> UIViewController {
        let viewController = UserProfileViewController()
        let presenter = UserProfilePresenter()
        let interactor = UserProfileInteractor()
        let router = UserProfileRouter()
        
        let networkService = ProfileService.shared
        
        viewController.presenter = presenter
        viewController.userId = userId
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.service = networkService
        
        router.viewController = viewController
        
        return viewController
    }
}
