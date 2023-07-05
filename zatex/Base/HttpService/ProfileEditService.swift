//
//  ProfileEditService.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.07.2023.
//

import Alamofire

class ProfileEditService {
    private lazy var httpService = ProfileEditHttpService()
    static let shared: ProfileEditService = ProfileEditService()
}

extension ProfileEditService: ProfileEditAPI {

    func fetchStoreInfo(
        authorId: Int,
        completion: @escaping ProfileInfoClosure
    ) {
        do {
            try ProfileEditHttpRouter
                .getStoreInfo(id: authorId)
                .request(usingHttpService: httpService)
                .responseDecodable(of: StoreInfoResult.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        print("LOG: 8435879435789 Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG: 34534637 Ошибка получения информации о пользователе")
        }
    }
    
    func editStoreInfo(
        data: ProfileEditRequest,
        completion: @escaping ProfileEditInfoClosure
    ) {
        do {
            try ProfileEditHttpRouter
                .editStoreInfo(data: data)
                .request(usingHttpService: httpService)
                .response { response in
                    switch response.result {
                    case .success:
                        completion()
                    case .failure(let error):
                        print("LOG: 8908765745 Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG: 438767398486 Ошибка изменения информации о пользователе")
        }
    }
}
