//
//  FullscreenFullscreenPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol FullscreenPresenterProtocol: AnyObject {

}

class FullscreenPresenter: BasePresenter {
    weak var view: FullscreenViewControllerProtocol?
    var interactor: FullscreenInteractorProtocol?
    var router: FullscreenRouterProtocol?
    
}

extension FullscreenPresenter: FullscreenPresenterProtocol {
    
}
