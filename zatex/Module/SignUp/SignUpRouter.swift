//
//  SignUpSignUpRouter.swift
//  zatex
//
//  Created by winzero on 28/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol SignUpRouterProtocol: AnyObject {
    
    func routeToAdditionalInfo(closeViewHandler: @escaping () -> Void)
}

class SignUpRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension SignUpRouter: SignUpRouterProtocol {
    
    func routeToAdditionalInfo(closeViewHandler: @escaping () -> Void) {
        let view = AdditionalInfoAssembly.create(closeViewHandler: closeViewHandler)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
