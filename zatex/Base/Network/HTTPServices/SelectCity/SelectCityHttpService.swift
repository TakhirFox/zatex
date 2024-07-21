//
//  SelectCityHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.12.2023.
//

import Alamofire

final class SelectCityHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible, _ requestInterceptor: RequestInterceptor?) -> DataRequest {
        return sessionManager.request(urlRequest, interceptor: requestInterceptor).validate(statusCode: 200..<400)
    }
}
