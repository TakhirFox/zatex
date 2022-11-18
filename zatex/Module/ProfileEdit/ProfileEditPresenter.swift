//
//  ProfileEditProfileEditPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol ProfileEditPresenterProtocol: AnyObject {

}

class ProfileEditPresenter: BasePresenter {
    weak var view: ProfileEditViewControllerProtocol?
    var interactor: ProfileEditInteractorProtocol?
    var router: ProfileEditRouterProtocol?
    
}

extension ProfileEditPresenter: ProfileEditPresenterProtocol {
    
}
