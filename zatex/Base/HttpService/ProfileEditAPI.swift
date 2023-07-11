//
//  ProfileEditAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.07.2023.
//

import Foundation

typealias ProfileInfoClosure = (StoreInfoResult) -> (Void)
typealias ProfileEditInfoClosure = () -> (Void)

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
