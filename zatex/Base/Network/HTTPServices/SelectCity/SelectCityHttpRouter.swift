//
//  SelectCityHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.12.2023.
//

import Alamofire

enum SelectCityHttpRouter {
    case getCountry
    case getCity(country: String)
}

extension SelectCityHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case .getCountry:
            return "/wp-json/country/v1/countries"
            
        case .getCity:
            return "/wp-json/country/v1/cities"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getCountry,
                .getCity:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getCountry,
                .getCity:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getCountry:
            return nil
            
        case let .getCity(country):
            return [
                "country": country
            ]
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getCountry,
                .getCity:
            return nil
        }
    }
}
