//
//  CreateProductCreateProductRouter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol CreateProductRouterProtocol: AnyObject {
    func routeToDetail(id: Int)
}

class CreateProductRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension CreateProductRouter: CreateProductRouterProtocol {
    func routeToDetail(id: Int) {
        let view = DetailAssembly.create(id: id)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
