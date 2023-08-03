//
//  BaseNavigationController.swift
//  zatex
//
//  Created by Zakirov Tahir on 03.08.2023.
//

import UIKit

open class BaseNavigationController: UINavigationController {
    
    open override func pushViewController(
        _ viewController: UIViewController,
        animated: Bool
    ) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    open override func setViewControllers(
        _ viewControllers: [UIViewController],
        animated: Bool
    ) {
        if viewControllers.count > 1, let vc = viewControllers.last {
            vc.hidesBottomBarWhenPushed = true
        }
        super.setViewControllers(viewControllers, animated: animated)
    }
}
