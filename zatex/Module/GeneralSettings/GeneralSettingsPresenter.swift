//
//  GeneralSettingsGeneralSettingsPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol GeneralSettingsPresenterProtocol: AnyObject {
    
    func goToProfileEdit()
    func logout()
}

class GeneralSettingsPresenter: BasePresenter {
    
    weak var view: GeneralSettingsViewControllerProtocol?
    var interactor: GeneralSettingsInteractorProtocol?
    var router: GeneralSettingsRouterProtocol?
    var logoutHandler: (() -> Void) = {}
}

extension GeneralSettingsPresenter: GeneralSettingsPresenterProtocol {
    
    // MARK: To Router
    func goToProfileEdit() {
        router?.routeToProfileEdit()
    }
    
    // MARK: To Interactor
    func logout() {
        interactor?.logout()
        logoutHandler()
    }
    
    // MARK: To View
}
