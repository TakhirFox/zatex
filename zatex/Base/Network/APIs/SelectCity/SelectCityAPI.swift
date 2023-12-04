//
//  SelectCityAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.12.2023.
//

import Foundation

typealias CountriesClosure = (Result<[CoordinatesResult], NetworkError>) -> (Void)
typealias CitiesClosure = (Result<AddressResult, NetworkError>) -> (Void)

protocol SelectCityAPI {
    
    func fetchCountries(
        completion: @escaping CountriesClosure
    ) -> (Void)
    
    func fetchCities(
        country: String,
        completion: @escaping CitiesClosure
    ) -> (Void)
}
