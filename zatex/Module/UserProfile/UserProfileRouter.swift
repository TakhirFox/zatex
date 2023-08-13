//
//  UserProfileUserProfileRouter.swift
//  zatex
//
//  Created by winzero on 13/08/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol UserProfileRouterProtocol: AnyObject {
    func routeToDetail(id: Int)
    func routeToReview(id: String)
}

class UserProfileRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension UserProfileRouter: UserProfileRouterProtocol {
    
    func routeToDetail(id: Int) {
        let view = DetailAssembly.create(id: id)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToReview(id: String) {
        let view = ReviewsAssembly.create(id: id)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
