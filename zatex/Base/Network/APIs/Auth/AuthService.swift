//
//  AuthService.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.03.2023.
//

import Alamofire

class AuthService {
    private lazy var httpService = AuthHttpService()
    static let shared: AuthService = AuthService()
}

extension AuthService: AuthAPI {
    
    func fetchAuthorization(
        login: String,
        pass: String,
        completion: @escaping AuthClosure
    ) {
        do {
            try AuthHttpRouter
                .authorization(
                    login: login,
                    pass: pass
                )
                .request(usingHttpService: httpService)
                .cURLDescription { description in
                    print("LOG: authorization \(description)")
                }
                .responseDecodable(of: AuthResult.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 09909089878767 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 234234023402349 Ошибка авторизации")))
        }
    }
}
