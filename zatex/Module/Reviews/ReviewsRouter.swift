//
//  ReviewsReviewsRouter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 20/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol ReviewsRouterProtocol: AnyObject {
    func routeToProfile(id: Int)
}

class ReviewsRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension ReviewsRouter: ReviewsRouterProtocol {
    
    func routeToProfile(id: Int) {
        let view = UserProfileAssembly.create(userId: id)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
