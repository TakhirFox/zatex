//
//  FeedFeedRouter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol FeedRouterProtocol: AnyObject {
    func routeToSearchResult(text: String)
    func routeToDetail(id: String)
    
}

class FeedRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension FeedRouter: FeedRouterProtocol {
    func routeToSearchResult(text: String) {
        let view = SearchAssembly.create(searchText: text)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToDetail(id: String) {
        let view = DetailAssembly.create(id: id)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
}
