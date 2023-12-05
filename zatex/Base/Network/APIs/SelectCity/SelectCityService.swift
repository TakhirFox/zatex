//
//  SelectCityService.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.12.2023.
//

import Alamofire

class SelectCityService {
    private lazy var httpService = SelectCityHttpService()
    static let shared: SelectCityService = SelectCityService()
}

extension SelectCityService: SelectCityAPI {
    
    func fetchCountries(
        completion: @escaping CountriesClosure
    ) {
        do {
            try SelectCityHttpRouter
                .getCountry
                .request(usingHttpService: httpService)
                .responseDecodable(of: [CountriesResponse].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                        
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 423564235674537 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 23466234 Ошибка получения списка стран")))
        }
    }
    
    func fetchCities(
        country: String,
        completion: @escaping CountriesClosure
    ) {
        do {
            try SelectCityHttpRouter
                .getCity(
                    country: country
                )
                .request(usingHttpService: httpService)
                .responseDecodable(of: [CountriesResponse].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                        
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 2346346 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 43574357 Ошибка получения списка городов")))
        }
    }
}
