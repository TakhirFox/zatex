//
//  MapSetterMapSetterAssembly.swift
//  zatex
//
//  Created by winzero on 27/07/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class MapSetterAssembly {
    
    static func create(
        closeViewHandler: @escaping ((String) -> Void)
    ) -> UIViewController {
        let viewController = MapSetterViewController()
        let presenter = MapSetterPresenter()
        let interactor = MapSetterInteractor()
        let router = MapSetterRouter()
        let mapNetworkService = MapService.shared
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.closeViewHandler = closeViewHandler
        
        interactor.presenter = presenter
        interactor.mapService = mapNetworkService
        
        router.viewController = viewController
        
        return viewController
    }
    
}
