//
//  ProfileProfilePresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol ProfilePresenterProtocol: AnyObject {
    func goToSettings()
}

class ProfilePresenter: BasePresenter {
    weak var view: ProfileViewControllerProtocol?
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?
    
}

extension ProfilePresenter: ProfilePresenterProtocol {
    // MARK: To Interactor
    
    // MARK: To Router
    func goToSettings() {
        router?.routeToSettings()
    }
    
    // MARK: To View
}
