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
        let networkService = CreateProductService.shared
        let imageService = ImagesService.shared
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.service = networkService
        interactor.imageService = imageService
        
        router.viewController = viewController
        
        return viewController
    }
    
}
