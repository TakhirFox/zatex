//
//  SignUpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 28.05.2023.
//

import Alamofire

class SignUpService {
    private lazy var httpService = SignUpHttpService()
    static let shared: SignUpService = SignUpService()
}

extension SignUpService: SignUpAPI {
    func fetchSignUp(
        username: String,
        email: String,
        pass: String,
        completion: @escaping SignUpClosure
    ) {
        do {
            try SignUpHttpRouter
                .signUp(
                    username: username,
                    email: email,
                    password: pass
                )
                .request(usingHttpService: httpService)
                .responseDecodable(of: SignUpResult.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        print("LOG 23775296589328: Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG 9304869923467: Ошибка регистрации")
        }
    }
}
