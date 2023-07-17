//
//  AdditionalInfoAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.07.2023.
//

import Foundation

typealias AdditionalInfoClosure = () -> (Void)

protocol AdditionalInfoAPI {
    
    func additionalInfo(
        data: AdditionalInfoRequest,
        completion: @escaping AdditionalInfoClosure
    ) -> (Void)
}
