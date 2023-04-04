//
//  MapHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 04.04.2023.
//

import Alamofire

enum MapHttpRouter {
    case coordinates(address: String)
}

extension MapHttpRouter: HttpRouter {
    var baseUrlString: String {
        return "https://nominatim.openstreetmap.org"
    }
    
    var path: String {
        switch self {
        case .coordinates:
            return "/search"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .coordinates:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .coordinates:
            return [
                "Content-Type": "application/json; charset=UTF-8",
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .coordinates(let address):
            return [
                "q": address,
                "format": "json"
            ]
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .coordinates:
            return nil
        }
    }
}
