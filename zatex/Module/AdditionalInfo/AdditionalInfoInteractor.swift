//
//  AdditionalInfoAdditionalInfoInteractor.swift
//  zatex
//
//  Created by winzero on 17/07/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol AdditionalInfoInteractorProtocol {
    
    func signUpAndRoute(data: AdditionalInfoRequest)
    func uploadImage(image: UIImage, isBanner: Bool)
}

class AdditionalInfoInteractor: BaseInteractor {
    weak var presenter: AdditionalInfoPresenterProtocol?
    var service: AdditionalInfoAPI!
    var imageService: ImagesService!
}

extension AdditionalInfoInteractor: AdditionalInfoInteractorProtocol {
    
    func signUpAndRoute(data: AdditionalInfoRequest) {
        self.service.additionalInfo(data: data) {
            self.presenter?.signUpSuccess()
        }
    }
    
    func uploadImage(image: UIImage, isBanner: Bool) {
        self.imageService.loadImage(image: image) { result in
            self.presenter?.setImage(image: result, isBanner: isBanner)
        }
    }
}
