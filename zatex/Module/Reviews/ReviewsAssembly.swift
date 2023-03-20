//
//  ReviewsReviewsAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 20/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class ReviewsAssembly {
    static func create(id: String) -> UIViewController {
        let viewController = ReviewsViewController()
        let presenter = ReviewsPresenter()
        let interactor = ReviewsInteractor()
        let router = ReviewsRouter()
        
        let networkService = ReviewsService.shared
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.service = networkService
        interactor.id = id
        
        router.viewController = viewController
        
        return viewController
    }
    
}
