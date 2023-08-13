//
//  UserProfileUserProfilePresenter.swift
//  zatex
//
//  Created by winzero on 13/08/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol UserProfilePresenterProtocol: AnyObject {

}

class UserProfilePresenter: BasePresenter {
    weak var view: UserProfileViewControllerProtocol?
    var interactor: UserProfileInteractorProtocol?
    var router: UserProfileRouterProtocol?
    
}

extension UserProfilePresenter: UserProfilePresenterProtocol {
    
}
