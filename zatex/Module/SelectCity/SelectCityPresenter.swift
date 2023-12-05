//
//  SelectCitySelectCityPresenter.swift
//  zatex
//
//  Created by winzero on 05/12/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import Foundation

protocol SelectCityPresenterProtocol: AnyObject {
    func getCountries()
    func getCities(country: String)
    func saveAddressAndDismiss(country: String, city: String)
    
    func setCountries(data: [CountriesResponse])
    func setCities(data: [CountriesResponse])
    
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
    
    func saveAddressAndDismiss(country: String, city: String) {
        UserDefaults.standard.set(country, forKey: "MyCountry")
        UserDefaults.standard.set(city, forKey: "MyCity")
        
        view?.dismissView()
    }
    
    
    // TO VIEW
    
    func setCountries(data: [CountriesResponse]) {
        view?.showCountries(data: data)
    }
    
    func setCities(data: [CountriesResponse]) {
        view?.showCities(data: data)
    }
    
    func setError(data: String) {
        view?.showError(data: data)
    }
}
