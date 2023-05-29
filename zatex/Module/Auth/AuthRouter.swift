//
//  AuthAuthRouter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 08/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol AuthRouterProtocol: AnyObject {
    
    func routeToSignUp(closeViewHandler: @escaping () -> Void)
    func routeToResetPassword()
}

class AuthRouter: BaseRouter {
    
    weak var viewController: UIViewController?
}

extension AuthRouter: AuthRouterProtocol {
    
    func routeToSignUp(closeViewHandler: @escaping () -> Void) {
        let view = SignUpAssembly.create(closeViewHandler: closeViewHandler)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToResetPassword() {
        
    }
}
