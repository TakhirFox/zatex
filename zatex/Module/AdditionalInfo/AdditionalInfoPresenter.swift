//
//  AdditionalInfoAdditionalInfoPresenter.swift
//  zatex
//
//  Created by winzero on 17/07/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import Foundation

protocol AdditionalInfoPresenterProtocol: AnyObject {

    func saveAdditionalInfo(entity: AdditionalInfoEntity)
    
    func goToMap(saveAddressHandler: @escaping (String) -> Void)
    
    func setImage(image: MediaResult, isBanner: Bool)
    func signUpSuccess()
    func setToastError(text: String)
    func setToastImageError(text: String)
}

class AdditionalInfoPresenter: BasePresenter {
    
    weak var view: AdditionalInfoViewControllerProtocol?
    var interactor: AdditionalInfoInteractorProtocol?
    var router: AdditionalInfoRouterProtocol?
    var closeViewHandler: (() -> Void) = {}
    
    private let dispatchGroup = DispatchGroup()
    
    private var uploadedAvatar = ProductResponse.Image()
    private var uploadedBanner = ProductResponse.Image()
}

extension AdditionalInfoPresenter: AdditionalInfoPresenterProtocol {
    
    // MARK: To Interactor
    func saveAdditionalInfo(entity: AdditionalInfoEntity) {
        if entity.avatar != nil {
            dispatchGroup.enter()
            
            interactor?.uploadImage(
                image: entity.avatar!,
                isBanner: false
            )
        }
        
        if entity.banner != nil {
            dispatchGroup.enter()
            
            interactor?.uploadImage(
                image: entity.banner!,
                isBanner: true
            )
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            let address = AdditionalInfoRequest.Address(
                street1: entity.address
            )
            
            let info = AdditionalInfoRequest(
                storeName: entity.storeName,
                firstName: entity.firstName,
                lastName: entity.lastName,
                phone: entity.phone,
                address: address,
                banner: self?.uploadedBanner.src,
                bannerID: self?.uploadedBanner.position,
                gravatar: self?.uploadedAvatar.src,
                gravatarID: self?.uploadedAvatar.position,
                isShop: entity.isShop
            )
            
            self?.interactor?.signUpAndRoute(data: info)
        }
    }
    
    // MARK: To Router
    func goToMap(saveAddressHandler: @escaping (String) -> Void) {
        router?.routeToMap(saveAddressHandler: saveAddressHandler)
    }
    
    // MARK: To View
    
    func setImage(image: MediaResult, isBanner: Bool) {
        let urlImage = image.mediaDetails?.sizes?.woocommerceSingle?.sourceURL ?? ""
        let idImage = image.id ?? 0
        
        if isBanner {
            uploadedBanner.src = urlImage
            uploadedBanner.position = idImage
        } else {
            uploadedAvatar.src = urlImage
            uploadedAvatar.position = idImage
        }
        
        dispatchGroup.leave()
    }
    
    func signUpSuccess() {
        closeViewHandler()
    }
    
    func setToastError(text: String) {
        view?.showToastError(text: text)
    }
    
    func setToastImageError(text: String) {
        view?.showToastImageError(text: text)
    }
}
