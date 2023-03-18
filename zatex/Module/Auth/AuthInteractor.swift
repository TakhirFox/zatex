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
    var userSettings: UserSettingsAPI!
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
            
            if result.token != nil {
                self.userSettings.saveTokens(tokenData: result)
            }
            
            self.presenter?.authSuccess()
        }
    }
}
