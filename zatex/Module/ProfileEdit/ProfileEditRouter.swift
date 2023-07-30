//
//  ProfileEditProfileEditRouter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol ProfileEditRouterProtocol: AnyObject {
    
    func routeToMap(
        saveAddressHandler: @escaping (String) -> Void
    )
}

class ProfileEditRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension ProfileEditRouter: ProfileEditRouterProtocol {
    
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
