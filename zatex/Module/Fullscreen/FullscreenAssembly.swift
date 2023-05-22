//
//  FullscreenFullscreenAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class FullscreenAssembly {
    static func create(images: [String], selected: Int) -> UIViewController {
        let viewController = FullscreenViewController()
        let presenter = FullscreenPresenter()
        let interactor = FullscreenInteractor()
        let router = FullscreenRouter()
        
        viewController.presenter = presenter
        viewController.images = images
        viewController.selectedId = selected
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
}
