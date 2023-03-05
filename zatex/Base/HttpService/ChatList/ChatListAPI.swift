//
//  ChatListAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import Foundation

typealias ChatListClosure = ([ChatListResult]) -> (Void)

protocol ChatListAPI  {
    
    func fetchChats(
        completion: @escaping ChatListClosure
    ) -> Void
}
