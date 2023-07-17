//
//  AdditionalInfoAdditionalInfoAssembly.swift
//  zatex
//
//  Created by winzero on 17/07/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class AdditionalInfoAssembly {
    static func create(closeViewHandler: @escaping (() -> Void)) -> UIViewController {
        let viewController = AdditionalInfoViewController()
        let presenter = AdditionalInfoPresenter()
        let interactor = AdditionalInfoInteractor()
        let router = AdditionalInfoRouter()
        
        let networkService = AdditionalInfoService.shared
        let imageService = ImagesService.shared
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.closeViewHandler = closeViewHandler
        
        interactor.presenter = presenter
        interactor.service = networkService
        interactor.imageService = imageService
        
        router.viewController = viewController
        
        return viewController
    }
    
}
