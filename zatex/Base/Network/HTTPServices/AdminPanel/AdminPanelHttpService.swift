//
//  AdminPanelHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 15.01.2024.
//

import Alamofire

final class AdminPanelHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible, _ requestInterceptor: RequestInterceptor?) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
