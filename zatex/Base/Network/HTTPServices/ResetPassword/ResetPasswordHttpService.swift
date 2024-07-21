//
//  ResetPasswordHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 30.05.2023.
//

import Alamofire

final class ResetPasswordHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible, _ requestInterceptor: RequestInterceptor?) -> DataRequest {
        return sessionManager.request(urlRequest, interceptor: requestInterceptor).validate(statusCode: 200..<400)
    }
}
