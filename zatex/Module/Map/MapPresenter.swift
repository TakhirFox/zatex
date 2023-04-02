//
//  MapMapPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 02/04/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol MapPresenterProtocol: AnyObject {
    
    func showMapPlace()
    
    func setMapPlace()
}

class MapPresenter: BasePresenter {
    
    weak var view: MapViewControllerProtocol?
    var interactor: MapInteractorProtocol?
    var router: MapRouterProtocol?
    var coordinates: CoordinareEntity?
}

extension MapPresenter: MapPresenterProtocol {
    
    func showMapPlace() {
        setMapPlace()
    }
    
    // MARK: To View
    func setMapPlace() {
        view?.setMapPlace(coordinates: coordinates!)
    }
}
