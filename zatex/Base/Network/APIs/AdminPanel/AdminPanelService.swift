//
//  AdminPanelService.swift
//  zatex
//
//  Created by Zakirov Tahir on 15.01.2024.
//

import Alamofire

class AdminPanelService {
    private lazy var httpService = AdminPanelHttpService()
    static let shared: AdminPanelService = AdminPanelService()
}

extension AdminPanelService: AdminPanelAPI {
    
    func fetchUserList(
        page: Int,
        completion: @escaping UserListClosure
    ) {
        do {
            try AdminPanelHttpRouter
                .getUserList(page: page)
                .request(usingHttpService: httpService)
                .cURLDescription { description in
                    print("LOG: getUserList \(description)")
                }
                .responseDecodable(of: [UserResponse].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                        
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 786657456345 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 435743573457 Ошибка получения списка пользователей")))
        }
    }
}
