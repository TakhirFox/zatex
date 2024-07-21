//
//  EditProductHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.01.2024.
//

import Alamofire

final class EditProductHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible, _ requestInterceptor: RequestInterceptor?) -> DataRequest {
        return sessionManager.request(urlRequest, interceptor: requestInterceptor).validate(statusCode: 200..<400)
    }
}
