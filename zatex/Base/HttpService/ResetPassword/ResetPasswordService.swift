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
                        completion()
                    case .failure(let error):
                        print("LOG 79834798347: Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG 34780734805345789: Ошибка сброса пароля")
        }
    }
}
