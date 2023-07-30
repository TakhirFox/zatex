//
//  ProfileEditAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.07.2023.
//

import Foundation

typealias ProfileInfoClosure = (Result<StoreInfoResult, NetworkError>) -> (Void)
typealias ProfileEditInfoClosure = (Result<(), NetworkError>) -> (Void)

protocol ProfileEditAPI {
    
    func fetchStoreInfo(
        authorId: Int,
        completion: @escaping ProfileInfoClosure
    ) -> (Void)
    
    func editStoreInfo(
        data: ProfileEditRequest,
        completion: @escaping ProfileEditInfoClosure
    ) -> (Void)
}
