//
//  AuthAuthInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 08/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol AuthInteractorProtocol {
    func authAndRoute(login: String, pass: String)
}

class AuthInteractor: BaseInteractor {
    weak var presenter: AuthPresenterProtocol?
    var service: AuthAPI!
    var sessionProvider: SessionProvider!
}

extension AuthInteractor: AuthInteractorProtocol {
    func authAndRoute(
        login: String,
        pass: String
    ) {
        self.service.fetchAuthorization(
            login: login,
            pass: pass
        ) { result in
            switch result {
            case let .success(data):
                self.sessionProvider.setSession(data)
                self.presenter?.authSuccess()
                
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
