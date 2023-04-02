//
//  DetailRouter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 03/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol DetailRouterProtocol: AnyObject {
    func routeToMessage(chatId: String)
    func routeToMap(coordinates: CoordinareEntity)
    func routeToDetail(id: Int)
}

class DetailRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension DetailRouter: DetailRouterProtocol {
    func routeToMessage(chatId: String) {
        let view = ChatDetailAssembly.create(chatId: chatId)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToMap(coordinates: CoordinareEntity) {
        let view = MapAssembly.create(coordinates: coordinates)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToDetail(id: Int) {
        let view = DetailAssembly.create(id: id)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
