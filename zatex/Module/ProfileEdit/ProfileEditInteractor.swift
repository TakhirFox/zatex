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
            switch result {
            case let .success(data):
                self.presenter?.setProfileInfo(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastGetProfileError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setToastGetProfileError(text: name)
                }
            }
        }
    }
    
    func updateProfileInfo(data: ProfileEditRequest) {
        self.service.editStoreInfo(data: data) { result in 
            switch result {
            case .success:
                self.presenter?.successUpdateInfo()
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastUpdateProfileError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setToastUpdateProfileError(text: name)
                }
            }
        }
    }
    
    func uploadImage(image: UIImage, isBanner: Bool) {
        self.imageService.loadImage(image: image) { result in
            switch result {
            case let .success(data):
                self.presenter?.setImage(image: data, isBanner: isBanner)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastImageError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setToastImageError(text: name)
                }
            }
        }
    }
}
