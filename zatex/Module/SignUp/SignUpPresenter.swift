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
        if let username = username, username == ""  {
            //            view?.showLoginIsEmpty() // TODO: Допилить
        }
        
        if let email = email, email == ""  {
            //            view?.showLoginIsEmpty() // TODO: Допилить
        }
        
        if let pass = pass, pass == ""  {
            //            view?.showPassIsEmpty() // TODO: Допилить
            
        }
        
        if let username = username, username != "",
           let email = email, email != "",
           let pass = pass, pass != "" {
            signUpAndRoute(
                username: username,
                email: email,
                pass: pass
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
}
