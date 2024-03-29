//
//  SignUpHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 28.05.2023.
//

import Alamofire

final class SignUpHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
