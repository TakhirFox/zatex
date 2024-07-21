//
//  ProfileEditHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.07.2023.
//

import Alamofire

final class ProfileEditHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible, _ requestInterceptor: RequestInterceptor?) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
