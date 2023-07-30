//
//  ChatListAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import Foundation

typealias ChatListClosure = (Result<[ChatListResult], NetworkError>) -> (Void)

protocol ChatListAPI  {
    
    func fetchChats(
        completion: @escaping ChatListClosure
    ) -> Void
}
