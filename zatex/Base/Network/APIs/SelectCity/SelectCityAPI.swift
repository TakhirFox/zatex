//
//  SelectCityAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.12.2023.
//

import Foundation

typealias CountriesClosure = (Result<[CountriesResponse], NetworkError>) -> (Void)

protocol SelectCityAPI {
    
    func fetchCountries(
        completion: @escaping CountriesClosure
    ) -> (Void)
    
    func fetchCities(
        country: String,
        completion: @escaping CountriesClosure
    ) -> (Void)
}
