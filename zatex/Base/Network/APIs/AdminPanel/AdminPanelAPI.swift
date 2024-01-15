//
//  AdminPanelAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 15.01.2024.
//

import Foundation

typealias UserListClosure = (Result<[UserResponse], NetworkError>) -> (Void)

protocol AdminPanelAPI {
    
    func fetchUserList(
        page: Int,
        completion: @escaping UserListClosure
    ) -> (Void)
}
