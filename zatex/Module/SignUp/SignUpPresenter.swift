//
//  SignUpSignUpPresenter.swift
//  zatex
//
//  Created by winzero on 28/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol SignUpPresenterProtocol: AnyObject {
    
    func checkTextFieldEmpty(
        username: String?,
        email: String?,
        pass: String?
    )
    
    func goToAdditionalInfoView()
    func setToastError(text: String)
}

class SignUpPresenter: BasePresenter {
    
    weak var view: SignUpViewControllerProtocol?
    var interactor: SignUpInteractorProtocol?
    var router: SignUpRouterProtocol?
    var closeViewHandler: (() -> Void) = {}
}

extension SignUpPresenter: SignUpPresenterProtocol {
    
    // MARK: To Interactor
    func checkTextFieldEmpty(
        username: String?,
        email: String?,
        pass: String?
    ) {
        if username == nil  {
            view?.showEmptyUsername()
        }
        
        if email == nil  {
            view?.showEmptyEmail()
        }
        
        if pass == nil  {
            view?.showEmptyPassword()
        }
        
        if username != nil,
           email != nil,
           pass != nil {
            signUpAndRoute(
                username: username!,
                email: email!,
                pass: pass!
            )
        }
    }
    
    private func signUpAndRoute(
        username: String,
        email: String,
        pass: String
    ) {
        interactor?.signUpAndRoute(
            username: username,
            email: email,
            pass: pass
        )
    }
    
    // MARK: To Router
    func goToAdditionalInfoView() {
        router?.routeToAdditionalInfo { [weak self] in
            self?.closeViewHandler()
        }
    }
    
    // MARK: To View
    func setToastError(text: String) {
        view?.showToastError(text: text)
    }
}
