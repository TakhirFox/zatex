//
//  EditProductEditProductAssembly.swift
//  zatex
//
//  Created by winzero on 22/01/2024.
//  Copyright © 2024 zakirovweb. All rights reserved.
//

import UIKit

class EditProductAssembly {
    
    static func create(productId: Int) -> UIViewController {
        let viewController = EditProductViewController()
        let presenter = EditProductPresenter()
        let interactor = EditProductInteractor()
        let router = EditProductRouter()
        let networkService = EditProductService.shared
        let imageService = ImagesService.shared
        let createProductService = CreateProductService.shared
        
        viewController.presenter = presenter
        viewController.productId = productId
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.service = networkService
        interactor.imageService = imageService
        interactor.createProductService = createProductService
        
        router.viewController = viewController
        
        return viewController
    }
}
