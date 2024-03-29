//
//  SignUpSignUpInteractor.swift
//  zatex
//
//  Created by winzero on 28/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol SignUpInteractorProtocol {
    
    func signUpAndRoute(
        username: String,
        email: String,
        pass: String
    )
}

class SignUpInteractor: BaseInteractor {
    
    weak var presenter: SignUpPresenterProtocol?
    var service: SignUpAPI!
    var sessionProvider: SessionProvider!
}

extension SignUpInteractor: SignUpInteractorProtocol {
    
    func signUpAndRoute(
        username: String,
        email: String,
        pass: String
    ) {
        self.service.fetchSignUp(
            username: username,
            email: email,
            pass: pass
        ) { result in
            switch result {
            case let .success(data):
                if data.token != nil {
                    let session = AuthResult( // TODO: Change to SessionModel
                        userId: data.userID,
                        token: data.token,
                        userEmail: data.userEmail,
                        userNicename: data.userNicename,
                        userDisplayName: nil
                    )
                    
                    self.sessionProvider.setSession(session)
                    self.presenter?.goToAdditionalInfoView()
                }
                
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
