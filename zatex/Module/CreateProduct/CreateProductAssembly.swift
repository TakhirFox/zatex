//
//  CreateProductCreateProductAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

class CreateProductAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = CreateProductViewController()
        let presenter = CreateProductPresenter()
        let interactor = CreateProductInteractor()
        let router = CreateProductRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
}