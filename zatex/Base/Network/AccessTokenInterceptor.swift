//
//  AccessTokenInterceptor.swift
//  zatex
//
//  Created by Zakirov Tahir on 21.07.2024.
//

import Alamofire

final class AccessTokenInterceptor: RequestInterceptor {
    
    private var isRefreshing = false
    private let userSettingsService: UserSettingsAPI
    private let httpService: AuthHttpService = AuthHttpService()
    
    private var accessToken: String? {
        return userSettingsService.token
    }
    
    private var refreshToken: String? {
        return userSettingsService.getSession()?.refreshToken
    }
    
    init(userSettingsService: UserSettingsAPI) {
        self.userSettingsService = userSettingsService
    }
}

extension AccessTokenInterceptor {
    
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var request = urlRequest
        
        if let token = accessToken {
            request.headers.update(.authorization(bearerToken: token))
        }
        
        completion(.success(request))
    }
    
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        
        switch statusCode {
        case 200...299:
            completion(.doNotRetry)
            
        case 401:
            guard !isRefreshing else { return }
            
            refreshTokens { tokenData in
                if let tokenData = tokenData {
                    self.userSettingsService.saveAccess(token: tokenData.accessToken)
                }
                
                completion(.retry)
            }
            
            break
            
        default:
            completion(.retry)
        }
    }
}

extension AccessTokenInterceptor {
    private typealias RefreshCompletion = (_ refreshToken: RefreshResult?) -> Void
    
    private func refreshTokens(completion: @escaping RefreshCompletion) {
        
        self.isRefreshing = true
        
        guard let tokenData = userSettingsService.getSession()?.refreshToken else { return }
        
        AuthService.shared.refreshAuthorization(token: tokenData) { [weak self] result in
            self?.isRefreshing = false
            
            switch result {
            case .success(let success):
                completion(success)
                
            case .failure:
                self?.userSettingsService.clearSession()
            }
        }
    }
}

struct RefreshTokenResult: Decodable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
