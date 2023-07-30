//
//  ResetPasswordService.swift
//  zatex
//
//  Created by Zakirov Tahir on 30.05.2023.
//

import Alamofire

class ResetPasswordService {
    private lazy var httpService = ResetPasswordHttpService()
    static let shared: ResetPasswordService = ResetPasswordService()
}

extension ResetPasswordService: ResetPasswordAPI {
    
    func fetchResetPassword(
        username: String,
        completion: @escaping ResetPasswordClosure
    ) {
        do {
            try ResetPasswordHttpRouter
                .resetPassword(username: username)
                .request(usingHttpService: httpService)
                .cURLDescription { description in
                    print("LOG: resetPassword \(description)")
                }
                .response { response in
                    switch response.result {
                    case .success:
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 79834798347 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 34780734805345789 Ошибка сброса пароля")))
        }
    }
}
