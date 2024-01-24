//
//  EditProductEditProductRouter.swift
//  zatex
//
//  Created by winzero on 22/01/2024.
//  Copyright © 2024 zakirovweb. All rights reserved.
//

import UIKit

protocol EditProductRouterProtocol: AnyObject {
    func routeToBack()
}

class EditProductRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension EditProductRouter: EditProductRouterProtocol {
    
    func routeToBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
