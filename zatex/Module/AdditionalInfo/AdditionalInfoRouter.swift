//
//  AdditionalInfoAdditionalInfoRouter.swift
//  zatex
//
//  Created by winzero on 17/07/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol AdditionalInfoRouterProtocol: AnyObject {
    
    func routeToMap(
        saveAddressHandler: @escaping (String) -> Void
    )
}

class AdditionalInfoRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension AdditionalInfoRouter: AdditionalInfoRouterProtocol {
    
    func routeToMap(
        saveAddressHandler: @escaping (String) -> Void
    ) {
        let view = MapSetterAssembly.create { [weak self] address in
            saveAddressHandler(address)
            self?.viewController?.navigationController?.popViewController(animated: true)
        }
        
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
