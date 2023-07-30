//
//  AuthHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.03.2023.
//

import Alamofire

final class AuthHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
