//
//  MapSetterMapSetterInteractor.swift
//  zatex
//
//  Created by winzero on 27/07/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol MapSetterInteractorProtocol {
    
    func getAddress(coordinates: CoordinareEntity)
    func findAdress(from addess: String)
}

class MapSetterInteractor: BaseInteractor {
    weak var presenter: MapSetterPresenterProtocol?
    var mapService: MapAPI!
}

extension MapSetterInteractor: MapSetterInteractorProtocol {
    
    func findAdress(from addess: String) {
        self.mapService.directGeocoding(address: addess) { result in
            switch result {
            case let .success(data):
                self.presenter?.setAddressList(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastMapError(text: name)
                    break
                case let .secondError(name):
                    self.presenter?.setToastMapError(text: name)
                    break
                }
            }
        }
    }
    
    func getAddress(coordinates: CoordinareEntity) {
        self.mapService.reverseGeocoding(coordinates: coordinates) { result in
            switch result {
            case let .success(data):
                self.presenter?.setAddress(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastMapError(text: name)
                    break
                case let .secondError(name):
                    self.presenter?.setToastMapError(text: name)
                    break
                }
            }
        }
    }
}
