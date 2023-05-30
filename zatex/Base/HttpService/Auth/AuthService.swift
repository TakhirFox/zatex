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
                        completion(data)
                    case .failure(let error):
                        print("LOG 09909089878767: Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG 234234023402349: Ошибка авторизации")
        }
    }
}
