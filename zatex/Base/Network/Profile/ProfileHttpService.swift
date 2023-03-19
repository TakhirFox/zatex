//
//  ProfileHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 18.03.2023.
//

import Alamofire

final class ProfileHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
