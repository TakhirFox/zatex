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
    
    func fetchChats(completion: @escaping ChatListClosure) {
        
        do {
            try ChatListHttpRouter
                .getChatList
                .request(usingHttpService: httpService)
                .responseDecodable(of: [ChatListResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                        guard !data.isEmpty else { return }
                    case .failure(let error):
                        print("LOG: 23598238 Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG: 9802355678456 Ошибка списка чата")
        }
    }
}
