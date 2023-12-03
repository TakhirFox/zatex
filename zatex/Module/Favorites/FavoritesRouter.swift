//
//  FavoritesFavoritesRouter.swift
//  zatex
//
//  Created by winzero on 27/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol FavoritesRouterProtocol: AnyObject {
    
    func routeToDetail(id: Int)
}

class FavoritesRouter: BaseRouter {
    
    weak var viewController: UIViewController?
}

extension FavoritesRouter: FavoritesRouterProtocol {
    
    func routeToDetail(id: Int) {
        let view = DetailAssembly.create(id: id)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
