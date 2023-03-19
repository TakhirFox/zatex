//
//  ReviewsReviewsAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 20/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class ReviewsAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = ReviewsViewController()
        let presenter = ReviewsPresenter()
        let interactor = ReviewsInteractor()
        let router = ReviewsRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
}