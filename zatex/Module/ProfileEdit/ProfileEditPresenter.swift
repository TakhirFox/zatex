//
//  ProfileEditProfileEditPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import Foundation

protocol ProfileEditPresenterProtocol: AnyObject {
    
    func getProfileInfo(id: Int)
    func updateProfileInfo(data: UpdateInfoEntity)
    
    func goToMap(saveAddressHandler: @escaping (AddressResult) -> Void)
    
    func setProfileInfo(data: StoreInfoResult)
    func setImage(image: MediaResult, isBanner: Bool)
    func successUpdateInfo()
    func setToastGetProfileError(text: String)
    func setToastUpdateProfileError(text: String)
    func setToastImageError(text: String)
}

class ProfileEditPresenter: BasePresenter {
    weak var view: ProfileEditViewControllerProtocol?
    var interactor: ProfileEditInteractorProtocol?
    var router: ProfileEditRouterProtocol?
    
    private let dispatchGroup = DispatchGroup()
    
    private var uploadedAvatar = ProductResponse.Image()
    private var uploadedBanner = ProductResponse.Image()
}

extension ProfileEditPresenter: ProfileEditPresenterProtocol {
    
    // MARK: To Interactor
    func getProfileInfo(id: Int) {
        interactor?.getProfileInfo(id: id)
    }
    
    func updateProfileInfo(data: UpdateInfoEntity) {
        if data.localAvatar != nil {
            dispatchGroup.enter()
            
            interactor?.uploadImage(
                image: data.localAvatar!,
                isBanner: false
            )
        }
        
        if data.localBanner != nil {
            dispatchGroup.enter()
            
            interactor?.uploadImage(
                image: data.localBanner!,
                isBanner: true
            )
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            let address = ProfileEditRequest.Address(
                street1: data.address?.street,
                city: data.address?.city,
                country: data.address?.country
            )
            
            let updatedInfo = ProfileEditRequest(
                storeName: data.storeName,
                firstName: data.firstName,
                lastName: data.lastName,
                phone: data.phone,
                address: address,
                banner: self?.uploadedBanner.src,
                bannerID: self?.uploadedBanner.position,
                gravatar: self?.uploadedAvatar.src,
                gravatarID: self?.uploadedAvatar.position,
                isShop: data.isShop
            )
            
            self?.interactor?.updateProfileInfo(data: updatedInfo)
        }
    }
    
    // MARK: To Router
    func goToMap(saveAddressHandler: @escaping (AddressResult) -> Void) {
        router?.routeToMap(saveAddressHandler: saveAddressHandler)
    }
    
    // MARK: To View
    func setProfileInfo(data: StoreInfoResult) {
        view?.setProfileInfo(data: data)
    }
    
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
    
    func successUpdateInfo() {
        view?.successUpdateInfo()
    }
    
    func setToastGetProfileError(text: String) {
        view?.showToastGetProfileError(text: text)
    }
    
    func setToastUpdateProfileError(text: String) {
        view?.showToastUpdateProfileError(text: text)
    }
    
    func setToastImageError(text: String) {
        view?.showToastImageError(text: text)
    }
}
