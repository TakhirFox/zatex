//
//  GeneralSettingsGeneralSettingsPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol GeneralSettingsPresenterProtocol: AnyObject {
    func goToProfileEdit()
    
}

class GeneralSettingsPresenter: BasePresenter {
    weak var view: GeneralSettingsViewControllerProtocol?
    var interactor: GeneralSettingsInteractorProtocol?
    var router: GeneralSettingsRouterProtocol?
    
}

extension GeneralSettingsPresenter: GeneralSettingsPresenterProtocol {
    func goToProfileEdit() {
        router?.routeToProfileEdit()
    }
    
}
