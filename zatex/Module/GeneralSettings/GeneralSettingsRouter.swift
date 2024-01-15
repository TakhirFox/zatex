//
//  GeneralSettingsGeneralSettingsRouter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol GeneralSettingsRouterProtocol: AnyObject {
    func routeToProfileEdit()
    func routeToAdminPanel()
    
}

class GeneralSettingsRouter: BaseRouter {
    
    weak var viewController: UIViewController?
    
}

extension GeneralSettingsRouter: GeneralSettingsRouterProtocol {
    
    func routeToProfileEdit() {
        let view = ProfileEditAssembly.create()
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToAdminPanel() {
        let view = AdminPanelAssembly.create(type: .main)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
