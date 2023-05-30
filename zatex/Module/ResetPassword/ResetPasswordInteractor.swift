//
//  ResetPasswordResetPasswordInteractor.swift
//  zatex
//
//  Created by winzero on 30/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol ResetPasswordInteractorProtocol {
    
    func resetPassword(username: String)
}

class ResetPasswordInteractor: BaseInteractor {
    
    weak var presenter: ResetPasswordPresenterProtocol?
    var service: ResetPasswordAPI!
}

extension ResetPasswordInteractor: ResetPasswordInteractorProtocol {
    
    func resetPassword(username: String) {
        self.service.fetchResetPassword(
            username: username
        ) {
            self.presenter?.showSuccessDialog()
        }
    }
}
