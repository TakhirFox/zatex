//
//  DetailAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 03/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

class DetailAssembly {
    static func create(id: Int) -> UIViewController {
        let viewController = DetailViewController()
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        
        let networkService = ProductDetailService.shared
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.service = networkService
        interactor.productId = id
        
        router.viewController = viewController
        
        return viewController
    }
    
}
