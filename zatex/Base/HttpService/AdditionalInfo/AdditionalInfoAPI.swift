//
//  AdditionalInfoAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.07.2023.
//

import Foundation

typealias AdditionalInfoClosure = (Result<(), NetworkError>) -> (Void)

protocol AdditionalInfoAPI {
    
    func additionalInfo(
        data: AdditionalInfoRequest,
        completion: @escaping AdditionalInfoClosure
    ) -> (Void)
}
