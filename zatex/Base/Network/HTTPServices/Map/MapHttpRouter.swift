//
//  MapHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 04.04.2023.
//

import Alamofire

enum MapHttpRouter {
    case directGeocoding(address: String)
    case reverseGeocoding(coordinates: CoordinareEntity)
}

extension MapHttpRouter: HttpRouter {
    
    var baseUrlString: String {
        return "https://nominatim.openstreetmap.org"
    }
    
    var path: String {
        switch self {
        case .directGeocoding:
            return "/search"
            
        case .reverseGeocoding:
            return "/reverse"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .directGeocoding,
                .reverseGeocoding:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .directGeocoding,
                .reverseGeocoding:
            return [
                "Content-Type": "application/json; charset=UTF-8",
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case let .directGeocoding(address):
            return [
                "q": address,
                "format": "json",
                "addressdetails": 1
            ]
            
        case let .reverseGeocoding(coordinates):
            return [
                "format": "jsonv2",
                "lat": coordinates.latitude,
                "lon": coordinates.longitude
            ]
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .directGeocoding,
                .reverseGeocoding:
            return nil
        }
    }
}
