//
//  MapMapAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 02/04/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class MapAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = MapViewController()
        let presenter = MapPresenter()
        let interactor = MapInteractor()
        let router = MapRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
}