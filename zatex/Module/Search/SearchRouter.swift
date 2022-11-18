//
//  SearchSearchRouter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 25/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol SearchRouterProtocol: AnyObject {
    func routeToDetail(id: String)
    
}

class SearchRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension SearchRouter: SearchRouterProtocol {
    func routeToDetail(id: String) {
        let view = DetailAssembly.create(id: id)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
}
