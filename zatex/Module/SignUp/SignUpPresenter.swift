//
//  SignUpSignUpPresenter.swift
//  zatex
//
//  Created by winzero on 28/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol SignUpPresenterProtocol: AnyObject {

}

class SignUpPresenter: BasePresenter {
    weak var view: SignUpViewControllerProtocol?
    var interactor: SignUpInteractorProtocol?
    var router: SignUpRouterProtocol?
    
}

extension SignUpPresenter: SignUpPresenterProtocol {
    
}
