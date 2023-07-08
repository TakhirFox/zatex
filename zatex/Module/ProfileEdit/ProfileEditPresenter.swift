//
//  ProfileEditProfileEditPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol ProfileEditPresenterProtocol: AnyObject {
    
    func getProfileInfo(id: Int)
    func updateProfileInfo(data: StoreInfoResult? )
    
    func setProfileInfo(data: StoreInfoResult)
    func successUpdateInfo()
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
    
    func updateProfileInfo(data: StoreInfoResult?) {
        
        let address = ProfileEditRequest.Address(
            street1: nil
        )
        
        let updatedInfo = ProfileEditRequest(
            storeName: data?.storeName,
            firstName: data?.firstName,
            lastName: data?.lastName,
            phone: data?.phone,
            address: address,
            banner: data?.banner,
            gravatar: data?.gravatar
        )
        
        interactor?.updateProfileInfo(data: updatedInfo)
    }
    
    // MARK: To Router
    
    // MARK: To View
    func setProfileInfo(data: StoreInfoResult) {
        view?.setProfileInfo(data: data)
    }
    
    func successUpdateInfo() {
        view?.successUpdateInfo()
    }
}
