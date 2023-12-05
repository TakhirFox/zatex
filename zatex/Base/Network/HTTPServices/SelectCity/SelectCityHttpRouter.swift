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
    
    var baseUrlString: String {
        return "https://api.countrystatecity.in"
    }
    
    var path: String {
        switch self {
        case .getCountry:
            return "/v1/countries"
            
        case let .getCity(country):
            return "/v1/countries/\(country)/cities"
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
                "Content-Type": "application/json; charset=UTF-8",
                "X-CSCAPI-KEY": "TXl4UVVERFFzem1Vd2FSaEtVdDFPSDJDUjQ4OUhUY25Od0MyZkl1Rg==",
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getCountry,
                .getCity:
            return nil
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
