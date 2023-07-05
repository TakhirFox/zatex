//
//  ProfileEditProfileEditPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol ProfileEditPresenterProtocol: AnyObject {
    
    func getProfileInfo(id: Int)
    
    func setProfileInfo(data: StoreInfoResult)
}

class ProfileEditPresenter: BasePresenter {
    weak var view: ProfileEditViewControllerProtocol?
    var interactor: ProfileEditInteractorProtocol?
    var router: ProfileEditRouterProtocol?
    
}

extension ProfileEditPresenter: ProfileEditPresenterProtocol {
    
    // MARK: To Interactor
    func getProfileInfo(id: Int) {
        interactor?.getProfileInfo(id: id)
    }
    
    // MARK: To Router
    
    // MARK: To View
    func setProfileInfo(data: StoreInfoResult) {
        view?.setProfileInfo(data: data)
    }
}
