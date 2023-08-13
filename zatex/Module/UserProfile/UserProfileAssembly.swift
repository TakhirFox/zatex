//
//  UserProfileUserProfileAssembly.swift
//  zatex
//
//  Created by winzero on 13/08/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class UserProfileAssembly: BaseAssemblyProtocol {
    
    static func create() -> UIViewController {
        let viewController = UserProfileViewController()
        let presenter = UserProfilePresenter()
        let interactor = UserProfileInteractor()
        let router = UserProfileRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
}
