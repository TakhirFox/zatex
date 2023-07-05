//
//  ProfileEditProfileEditInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol ProfileEditInteractorProtocol {
    
    func getProfileInfo(id: Int)
}

class ProfileEditInteractor: BaseInteractor {
    
    weak var presenter: ProfileEditPresenterProtocol?
    var service: ProfileEditAPI!
}

extension ProfileEditInteractor: ProfileEditInteractorProtocol {
    
    func getProfileInfo(id: Int) {
        self.service.fetchStoreInfo(authorId: id) { result in
            self.presenter?.setProfileInfo(data: result)
        }
    }
}
