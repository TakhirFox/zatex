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
        chatId: String,
        completion: @escaping ChatMessageClosure
    ) {
        do {
            try ChatDetailHttpRouter
                .getChatMessage(
                    chatId: chatId
                )
                .request(usingHttpService: httpService)
                .responseDecodable(of: [ChatMessageResult].self) { response in
                    if let responseData = response.data {
                        let text = String(data: responseData, encoding: .utf8)
                        print("LOG: getChatMessage: \(text ?? "---")")
                    }
                    
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                        guard !data.isEmpty else { return }
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 09989090990092 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 904539430375 Ошибка получения переписки")))
        }
    }
    
    func fetchChatInfo(
        chatId: String,
        completion: @escaping ChatInfoClosure
    ) {
        do {
            try ChatDetailHttpRouter
                .getChatInfo(chatId: chatId)
                .request(usingHttpService: httpService)
                .responseDecodable(of: ChatInfoResult.self) { response in
                    if let responseData = response.data {
                        let text = String(data: responseData, encoding: .utf8)
                        print("LOG: getChatInfo: \(text ?? "---")")
                    }
                    
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 43267435734 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 34573568245 Ошибка получения информации о чате")))
        }
    }
    
    func sendChatMessage(
        chatId: String,
        message: String,
        completion: @escaping SendMessageClosure
    ) {
        do {
            try ChatDetailHttpRouter
                .sendChatMessage(
                    chatId: chatId,
                    message: message
                )
                .request(usingHttpService: httpService)
                .cURLDescription { description in
                    print("LOG: sendChatMessage \(description)")
                }
                .responseDecodable(of: SendMessageResult.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 999898992292t342164 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 552888200023 Ошибка отправки сообщения")))
        }
    }
    
    func markMessage(
        messageId: String,
        completion: @escaping MarkMessageClosure
    ) {
        do {
            try ChatDetailHttpRouter
                .markMessage(messageId: messageId)
                .request(usingHttpService: httpService)
                .response { response in
                    switch response.result {
                    case .success:
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 23462337 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 569845868 Ошибка прочтения сообщения")))
        }
    }
}
