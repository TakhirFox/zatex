//
//  GeneralSettingsAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.11.2023.
//

import Foundation

typealias GeneralSettingsClosure = (Result<(), NetworkError>) -> (Void)

protocol GeneralSettingsAPI {
    
    func sendRequestDeleteAccount(
        data: DeleteAccountEmailRequest,
        completion: @escaping GeneralSettingsClosure
    ) -> (Void)
}
