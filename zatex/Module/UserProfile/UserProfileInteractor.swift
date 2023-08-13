//
//  UserProfileUserProfileInteractor.swift
//  zatex
//
//  Created by winzero on 13/08/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol UserProfileInteractorProtocol {
    
}

class UserProfileInteractor: BaseInteractor {
    weak var presenter: UserProfilePresenterProtocol?

}

extension UserProfileInteractor: UserProfileInteractorProtocol {
    
}
