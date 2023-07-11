//
//  ProfileEditProfileEditInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol ProfileEditInteractorProtocol {
    
    func getProfileInfo(id: Int)
    func updateProfileInfo(data: ProfileEditRequest)
    func uploadImage(image: UIImage, isBanner: Bool)
}

class ProfileEditInteractor: BaseInteractor {
    
    weak var presenter: ProfileEditPresenterProtocol?
    var service: ProfileEditAPI!
    var imageService: ImagesService!
}

extension ProfileEditInteractor: ProfileEditInteractorProtocol {
    
    func getProfileInfo(id: Int) {
        self.service.fetchStoreInfo(authorId: id) { result in
            self.presenter?.setProfileInfo(data: result)
        }
    }
    
    func updateProfileInfo(data: ProfileEditRequest) {
        self.service.editStoreInfo(data: data) {
            self.presenter?.successUpdateInfo()
        }
    }
    
    func uploadImage(image: UIImage, isBanner: Bool) {
        self.imageService.loadImage(image: image) { result in
            self.presenter?.setImage(image: result, isBanner: isBanner)
        }
    }
}
