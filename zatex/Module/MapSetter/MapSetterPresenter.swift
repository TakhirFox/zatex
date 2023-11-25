//
//  MapSetterMapSetterPresenter.swift
//  zatex
//
//  Created by winzero on 27/07/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol MapSetterPresenterProtocol: AnyObject {
    func showMapPlace(coordinates: CoordinareEntity)
    func getAddress(from coordinates: CoordinareEntity)
    func findAdress(from addess: String)
    
    func goToBackWith(address: String)
    
    func setMapPlace(coordinates: CoordinareEntity)
    func setAddress(data: AddressResult)
    func setAddressList(data: [CoordinatesResult])
    func setToastMapError(text: String)
}

class MapSetterPresenter: BasePresenter {
    
    weak var view: MapSetterViewControllerProtocol?
    var interactor: MapSetterInteractorProtocol?
    var router: MapSetterRouterProtocol?
    var coordinates: CoordinareEntity?
    var closeViewHandler: ((String) -> Void) = { _ in }
}

extension MapSetterPresenter: MapSetterPresenterProtocol {
    
    // MARK: To Interactor
    func showMapPlace(coordinates: CoordinareEntity) {
        setMapPlace(coordinates: coordinates)
    }
    
    func getAddress(from coordinates: CoordinareEntity) {
        interactor?.getAddress(coordinates: coordinates)
    }
    
    func findAdress(from addess: String) {
        interactor?.findAdress(from: addess)
    }
    
    // MARK: To Router
    func goToBackWith(address: String) {
        closeViewHandler(address)
    }
    
    // MARK: To View
    func setMapPlace(coordinates: CoordinareEntity) {
        view?.setMapPlace(
            coordinates: coordinates
        )
    }
    
    func setAddress(data: AddressResult) {
        let city = data.address.city ?? ""
        let road = data.address.road ?? ""
        let houseNumber = data.address.houseNumber ?? ""
        
        view?.setMapAddress(text: "\(city), \(road) \(houseNumber)")
    }
    
    func setAddressList(data: [CoordinatesResult]) {
        view?.showAddressList(data: data)
    }
    
    func setToastMapError(text: String) {
        view?.showToastMapError(text: text)
    }
}
