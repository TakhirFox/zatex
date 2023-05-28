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
            
            if result.token != nil {
                let session = AuthResult( // TODO: Change to SessionModel
                    userId: result.userID,
                    token: result.token,
                    userEmail: result.userEmail,
                    userNicename: result.userNicename,
                    userDisplayName: nil
                )
                
                self.sessionProvider.setSession(session)
                
                // Dismissed view. Updated profile view
            }
        }
    }
    
}
