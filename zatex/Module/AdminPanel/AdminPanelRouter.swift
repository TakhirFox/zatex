//
//  AdminPanelAdminPanelRouter.swift
//  zatex
//
//  Created by winzero on 14/01/2024.
//  Copyright © 2024 zakirovweb. All rights reserved.
//

import UIKit

protocol AdminPanelRouterProtocol: AnyObject {
    func routeToNext(type: AdminPanelPresenter.AdminPanelType)
}

class AdminPanelRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension AdminPanelRouter: AdminPanelRouterProtocol {
    
    func routeToNext(type: AdminPanelPresenter.AdminPanelType) {
        let view = AdminPanelAssembly.create(type: type)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
