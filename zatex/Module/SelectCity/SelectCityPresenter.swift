//
//  SelectCitySelectCityPresenter.swift
//  zatex
//
//  Created by winzero on 05/12/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol SelectCityPresenterProtocol: AnyObject {
    func getCountries()
    func getCities(country: String)
    
    func setCountries(data: [String])
    func setCities(data: [String])
    
    func setError(data: String)
}

class SelectCityPresenter: BasePresenter {
    
    weak var view: SelectCityViewControllerProtocol?
    var interactor: SelectCityInteractorProtocol?
    var router: SelectCityRouterProtocol?
}

extension SelectCityPresenter: SelectCityPresenterProtocol {
    
    // TO INTERACTOR
    
    func getCountries() {
        interactor?.getCountries()
    }
    
    func getCities(country: String) {
        interactor?.getCities(country: country)
    }
    
    
    // TO VIEW
    
    func setCountries(data: [String]) {
        view?.showCountries(data: data)
    }
    
    func setCities(data: [String]) {
        view?.showCities(data: data)
    }
    
    func setError(data: String) {
        view?.showError(data: data)
    }
}
