//
//  AuthAuthRouter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 08/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol AuthRouterProtocol: AnyObject {
    
    func routeToSignUp()
    func routeToResetPassword()
}

class AuthRouter: BaseRouter {
    
    weak var viewController: UIViewController?
}

extension AuthRouter: AuthRouterProtocol {
    
    func routeToSignUp() {
        let view = SignUpAssembly.create()
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToResetPassword() {
        
    }
}
