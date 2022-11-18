//
//  ProfileProfileInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol ProfileInteractorProtocol {
    
}

class ProfileInteractor: BaseInteractor, ProfileInteractorProtocol {
    weak var presenter: ProfilePresenterProtocol?

}