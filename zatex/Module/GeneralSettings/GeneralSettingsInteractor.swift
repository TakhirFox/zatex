//
//  GeneralSettingsGeneralSettingsInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol GeneralSettingsInteractorProtocol {
    func logout()
}

class GeneralSettingsInteractor: BaseInteractor {
    
    weak var presenter: GeneralSettingsPresenterProtocol?
    var sessionProvider: SessionProvider!
}

extension GeneralSettingsInteractor: GeneralSettingsInteractorProtocol {
    
    func logout() {
        self.sessionProvider.logout()
        
    }
}
