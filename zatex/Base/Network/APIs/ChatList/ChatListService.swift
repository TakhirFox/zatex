//
//  ChatListService.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import Alamofire

class ChatListService {
    private lazy var httpService = ChatListHttpService()
    static let shared: ChatListService = ChatListService()
}

extension ChatListService: ChatListAPI {
    
    func fetchChats(
        page: Int,
        completion: @escaping ChatListClosure
    ) {
        
        do {
            try ChatListHttpRouter
                .getChatList(page: page)
                .request(usingHttpService: httpService)
                .cURLDescription { description in
                    print("LOG: getChatList \(description)")
                }
                .responseDecodable(of: [ChatListResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                        guard !data.isEmpty else { return }
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 23598238 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 9802355678456 Ошибка списка чата")))
        }
    }
}
