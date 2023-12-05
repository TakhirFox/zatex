//
//  SelectCitySelectCityInteractor.swift
//  zatex
//
//  Created by winzero on 05/12/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol SelectCityInteractorProtocol {
    
    func getCountries()
    func getCities(country: String)
}

class SelectCityInteractor: BaseInteractor {
    
    weak var presenter: SelectCityPresenterProtocol?
    var service: SelectCityAPI!
}

extension SelectCityInteractor: SelectCityInteractorProtocol {
    
    func getCountries() {
        self.service.fetchCountries() { result in
            switch result {
            case let .success(data):
                self.presenter?.setCountries(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setError(data: name)
                    
                case let .secondError(name):
                    self.presenter?.setError(data: name)
                }
            }
        }
    }
    
    func getCities(country: String) {
        self.service.fetchCities(country: country) { result in
            switch result {
            case let .success(data):
                self.presenter?.setCities(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setError(data: name)
                    
                case let .secondError(name):
                    self.presenter?.setError(data: name)
                }
            }
        }
    }
}
