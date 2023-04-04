//
//  MapHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 04.04.2023.
//

import Alamofire

final class MapHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
