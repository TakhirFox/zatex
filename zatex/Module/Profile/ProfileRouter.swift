//
//  ProfileProfileRouter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func routeToSettings(logoutHandler: @escaping () -> Void)
    func routeToAuthView(signInHandler: @escaping () -> Void)
    func routeToDetail(id: Int)
    func routeToReview(id: String)
}

class ProfileRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension ProfileRouter: ProfileRouterProtocol {
    func routeToSettings(logoutHandler: @escaping () -> Void) {
        let view = GeneralSettingsAssembly.create(logoutHandler: logoutHandler)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToAuthView(signInHandler: @escaping () -> Void) {
        let view = AuthAssembly.create(authorizationHandler: signInHandler)
        view.modalPresentationStyle = .fullScreen
        viewController?.present(view, animated: true)
    }
    
    func routeToDetail(id: Int) {
        let view = DetailAssembly.create(id: id)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToReview(id: String) {
        let view = ReviewsAssembly.create(id: id)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
