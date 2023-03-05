//
//  ChatDetailService.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import Alamofire

class ChatDetailService {
    private lazy var httpService = ChatDetailHttpService()
    static let shared: ChatDetailService = ChatDetailService()
}

extension ChatDetailService: ChatDetailAPI {
    func fetchChatMessages(
        page: Int,
        chatId: String,
        completion: @escaping ChatMessageClosure
    ) {
        do {
            try ChatDetailHttpRouter
                .getChatMessage(chatId: chatId)
                .request(usingHttpService: httpService)
                .responseDecodable(of: [ChatMessageResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                        guard !data.isEmpty else { return }
                    case .failure(let error):
                        print("LOG 09989090990092: Ошибка  \(error)")
                    }
                }
            
        } catch {
            print("LOG 904539430375: Ошибка получения переписки")
        }
    }
}
