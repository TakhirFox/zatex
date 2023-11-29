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
    func routeToDetail(id: Int)
    func routeToNews(id: Int)
}

class FeedRouter: BaseRouter {
    
    weak var viewController: UIViewController?
}

extension FeedRouter: FeedRouterProtocol {
    
    func routeToSearchResult(text: String) {
        let view = SearchAssembly.create(searchText: text)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToDetail(id: Int) {
        let view = DetailAssembly.create(id: id)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToNews(id: Int) {
        let view = NewsAssembly.create()
        view.modalPresentationStyle = .overFullScreen
        viewController?.navigationController?.present(view, animated: true)
    }
}
