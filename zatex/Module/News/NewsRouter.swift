//
//  NewsNewsRouter.swift
//  zatex
//
//  Created by winzero on 29/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol NewsRouterProtocol: AnyObject {
    
}

class NewsRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension NewsRouter: NewsRouterProtocol {
    
}