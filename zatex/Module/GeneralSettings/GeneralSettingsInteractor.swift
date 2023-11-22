//
//  GeneralSettingsGeneralSettingsInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol GeneralSettingsInteractorProtocol {
    
    func deleteAccount(data: DeleteAccountEmailRequest)
}

class GeneralSettingsInteractor: BaseInteractor {
    
    weak var presenter: GeneralSettingsPresenterProtocol?
    var service: GeneralSettingsAPI!
}

extension GeneralSettingsInteractor: GeneralSettingsInteractorProtocol {
    
    func deleteAccount(data: DeleteAccountEmailRequest) {
        self.service.sendRequestDeleteAccount(data: data) { result in
            switch result {
            case .success:
                self.presenter?.showSuccessDialog()
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setToastError(text: name)
                }
            }
        }
    }
}
