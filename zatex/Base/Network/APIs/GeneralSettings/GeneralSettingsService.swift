//
//  GeneralSettingsService.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.11.2023.
//

import Alamofire

class GeneralSettingsService {
    private lazy var httpService = GeneralSettingsHttpService()
    static let shared: GeneralSettingsService = GeneralSettingsService()
}

extension GeneralSettingsService: GeneralSettingsAPI {
    
    func sendRequestDeleteAccount(
        data: DeleteAccountEmailRequest,
        completion: @escaping GeneralSettingsClosure
    ) {
        do {
            try GeneralSettingsHttpRouter
                .sendRequestDeleteAccount(data: data)
                .request(usingHttpService: httpService)
                .response { response in
                    switch response.result {
                    case .success:
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 34564356 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 438767398486 Ошибка запроса на удаление пользователя")))
        }
    }
}
