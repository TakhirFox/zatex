//
//  AdditionalInfoService.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.07.2023.
//

import Alamofire

class AdditionalInfoService {
    private lazy var httpService = AdditionalInfoHttpService()
    static let shared: AdditionalInfoService = AdditionalInfoService()
}

extension AdditionalInfoService: AdditionalInfoAPI {
    
    func additionalInfo(
        data: AdditionalInfoRequest,
        completion: @escaping AdditionalInfoClosure
    ) {
        do {
            try AdditionalInfoHttpRouter
                .additionalInfo(data: data)
                .request(usingHttpService: httpService)
                .response { response in
                    switch response.result {
                    case .success:
                        completion()
                    case .failure(let error):
                        print("LOG: 453745757 Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG: 3456346364 Ошибка изменения информации о пользователе")
        }
    }
}
