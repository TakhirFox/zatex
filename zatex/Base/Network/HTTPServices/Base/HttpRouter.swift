//
//  HttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.10.2022.
//

import Alamofire

protocol HttpRouter: URLRequestConvertible {
    var token: String { get }
    var baseUrlString: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    
    func body() throws -> Data?
    
    func request(usingHttpService service: HttpService) throws -> DataRequest
}

extension HttpRouter {
    var baseUrlString: String {
        return "https://zatex.ru"
    }
    
    var token: String {
        return UserSettingsService.shared.token
    }
    
    var parameter: Parameters? { return nil }
    func body() throws -> Data? { return nil }
    
    func asURLRequest() throws -> URLRequest {
        var url = try baseUrlString.asURL()
        url.appendPathComponent(path)
        
        var request = try URLRequest(url: url, method: method, headers: headers)
        request = try URLEncoding.default.encode(request, with: parameters)
        request.httpBody = try body()
        
        return request
    }
    
    func request(usingHttpService service: HttpService) throws -> DataRequest {
        return try service.request(asURLRequest())
    }
}
