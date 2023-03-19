//
//  ProfileProfileRouter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func routeToSettings()
    func routeToAuthView()
    func routeToDetail(id: String)
}

class ProfileRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension ProfileRouter: ProfileRouterProtocol {
    func routeToSettings() {
        let view = GeneralSettingsAssembly.create()
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToAuthView() {
        let view = AuthAssembly.create()
        viewController?.present(view, animated: true)
    }
    
    func routeToDetail(id: String) {
        let view = DetailAssembly.create(id: id)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
